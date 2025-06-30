--[[ 
-----------------------------------------------------
@filename       : InfiniteCityPrepPanel
@Description    : 无限城活动预备进入副本界面
@date           : 2021-03-01 16:34:52
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityPrepPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityPrepPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("infiniteCity_bg_4.jpg", false, "infiniteCity")
end
--析构  
function dtor(self)
end

function initData(self)
    self.mDisasterData = {}
    self.mDisasterItemList = {}
    self.mDisasterDesList = {}
    self.mSupplyShowList = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    self.mGroupInfo = self:getChildGO("mGroupInfo")

    self.mTxtStage = self:getChildGO("mTxtStage"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("mTxtStageName"):GetComponent(ty.Text)

    self.mBtnDetails = self:getChildGO("mBtnDetails")

    self.mGroupDisaster = self:getChildTrans("mGroupDisaster")

    self.mScollContent = self:getChildTrans("Content")

    self.mTxtScoreLab = self:getChildGO("mTxtScoreLab"):GetComponent(ty.Text)
    self.mTxtScrore = self:getChildGO("mTxtScrore"):GetComponent(ty.Text)
    self.mTxtSupply = self:getChildGO("mTxtSupply"):GetComponent(ty.Text)
    self.mTxtAllLv = self:getChildGO("mTxtAllLv"):GetComponent(ty.Text)
    self.mTxtLvLab = self:getChildGO("mTxtLvLab"):GetComponent(ty.Text)
    self.mGroupSupply = self:getChildGO("mGroupSupply")
    self.mGroupSupplyTrans = self:getChildTrans("mGroupSupply")

    self.mBtnClear = self:getChildGO("mBtnClear")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mImgArrow = self:getChildGO("mImgArrow")


    self.mTxtDeff = self:getChildGO("mTxtDeff"):GetComponent(ty.Text)
    self.mBtnChoose = self:getChildGO("mBtnChoose")
    self.mGroupDeff = self:getChildGO("mGroupDeff")
    self.mImgSelect = self:getChildTrans("mImgSelect")

    self.mBtnDeff1 = self:getChildGO("mBtnDeff1")
    self.mBtnDeff2 = self:getChildGO("mBtnDeff2")
    self.mBtnDeff3 = self:getChildGO("mBtnDeff3")
    self.mBtnDeff4 = self:getChildGO("mBtnDeff4")

    self.mImgDeffBg = self:getChildGO("mImgDeffBg"):GetComponent(ty.AutoRefImage)

    self.mTxtBoss = self:getChildGO("mTxtBoss"):GetComponent(ty.Text)
    self.mImgBoss = self:getChildGO("mImgBoss"):GetComponent(ty.AutoRefImage)

end
-- 设置货币栏
function setMoneyBar(self)
end
--激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_SUPPLY_DATA)

    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_DISASTER_SELECT_UPDATE, self.updateDisasterDesList, self)
    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_SUPPLY_SELECT_UPDATE, self.updateSupplyShowList, self)

    self.mDupId = args
    self.mDupData = infiniteCity.InfiniteCityManager:getDupBaseData(self.mDupId)

    self:updateView()
    self:updateLvAndScore()
    self:updateDisasterList()
    self:updateDisasterItem()
    self:updateDisasterDesList()
    self:updateChooseState()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_DISASTER_SELECT_UPDATE, self.updateDisasterDesList, self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_SUPPLY_SELECT_UPDATE, self.updateSupplyShowList, self)

    self:recoverListItem()
    self:recoverDisasterItem()

end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtStage.text = _TT(27148)--"STAGE"
    self.mTxtLvLab.text = _TT(27129)--"灾害等级"
    self.mTxtScoreLab.text = _TT(27149)--"通关评分"
    self.mTxtSupply.text = _TT(27150)--"战斗补给"

    self.mTxtDeff.text = _TT(27157) --"难度选择:"
    self:setBtnLabel(self.mBtnDeff1, 27158, "简单")
    self:setBtnLabel(self.mBtnDeff2, 27159, "普通")
    self:setBtnLabel(self.mBtnDeff3, 27160, "困难")
    self:setBtnLabel(self.mBtnDeff4, 27161, "噩梦")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mBtnClear, self.onClear)
    self:addUIEvent(self.mGroupSupply, self.onOpenSupply)
    self:addUIEvent(self.mBtnDetails, self.onOpenDetail)

    self:addUIEvent(self.mGroupDeff, self.onShowDeffChoose)
    self:addUIEvent(self.mBtnChoose, self.onShowDeffChoose)
    self:addUIEvent(self.mBtnDeff1, self.onDeffChoose1)
    self:addUIEvent(self.mBtnDeff2, self.onDeffChoose2)
    self:addUIEvent(self.mBtnDeff3, self.onDeffChoose3)
    self:addUIEvent(self.mBtnDeff4, self.onDeffChoose4)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    -- infiniteCity.InfiniteCityManager.selectDisasterList = {}
    infiniteCity.InfiniteCityManager.selectSupplyList = {}
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    -- infiniteCity.InfiniteCityManager.selectDisasterList = {}
    infiniteCity.InfiniteCityManager.selectSupplyList = {}

end

-- 布阵战斗
function onFight(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_INFINITE_CITY_SUPPLY_SELECT_PANEL)
    GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_CITY_PREP, { cityId = self.mDupData.id })
end

-- 清除
function onClear(self)
    infiniteCity.InfiniteCityManager.selectDisasterList = {}

    self:updateDisasterItem()
    self:updateDisasterDesList()
    self:updateLvAndScore()
end

function onShowDeffChoose(self)
    if self.mGroupDeff.activeSelf then
        self.mGroupDeff:SetActive(false)
    else
        self.mGroupDeff:SetActive(true)

        if infiniteCity.InfiniteCityManager.hardLevel == 1 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff1.transform)
        elseif infiniteCity.InfiniteCityManager.hardLevel == 2 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff2.transform)
        elseif infiniteCity.InfiniteCityManager.hardLevel == 3 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff3.transform)
        elseif infiniteCity.InfiniteCityManager.hardLevel == 4 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff4.transform)
        end
        self:updateDeffBtn()
    end
end

function onDeffChoose1(self)
    infiniteCity.InfiniteCityManager.hardLevel = 1
    self:updateChooseState()
end

function onDeffChoose2(self)
    infiniteCity.InfiniteCityManager.hardLevel = 2
    self:updateChooseState()
end

function onDeffChoose3(self)
    infiniteCity.InfiniteCityManager.hardLevel = 3
    self:updateChooseState()
end

function onDeffChoose4(self)
    infiniteCity.InfiniteCityManager.hardLevel = 4
    self:updateChooseState()
end

function updateChooseState(self)
    -- local str = { "简单", "普通", "困难", "噩梦" }
    local langId = { 27158, 27159, 27160, 27161 }
    self:setBtnLabel(self.mBtnChoose, langId[infiniteCity.InfiniteCityManager.hardLevel])
    self.mGroupDeff:SetActive(false)

    self.mImgDeffBg:SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", 67 + infiniteCity.InfiniteCityManager.hardLevel)))

    self:updateLvAndScore()
    self:updateDisasterScore()
end

function updateDeffBtn(self)
    local hardLevel = infiniteCity.InfiniteCityManager.hardLevel
    local selectStr = "<color='#000000'>%s</color>"
    local nomalStr = "<color='#ffffff'>%s</color>"
    self:setBtnLabel(self.mBtnDeff1, nil, hardLevel == 1 and string.format(selectStr, _TT(27158)) or string.format(nomalStr, _TT(27158)))
    self:setBtnLabel(self.mBtnDeff2, nil, hardLevel == 2 and string.format(selectStr, _TT(27159)) or string.format(nomalStr, _TT(27159)))
    self:setBtnLabel(self.mBtnDeff3, nil, hardLevel == 3 and string.format(selectStr, _TT(27160)) or string.format(nomalStr, _TT(27160)))
    self:setBtnLabel(self.mBtnDeff4, nil, hardLevel == 4 and string.format(selectStr, _TT(27161)) or string.format(nomalStr, _TT(27161)))
end

-- 打开补给选择
function onOpenSupply(self)
    self.mImgArrow:SetActive(true)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_SUPPLY_SELECT_PANEL, { dupData = self.mDupData, infoGroup = self.mGroupInfo })
end

function onOpenDetail(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_DISASTER_DETAIL_VIEW, self.mDupId)
end

function updateView(self)
    self.mTxtStageName.text = "行动地点：" .. self.mDupData.name
    self.mTxtName.text = _TT(27109) --"无限城"


    local vo = monster.MonsterManager:getMonsterVo(self.mDupData.bossId)
    local vo1 = monster.MonsterManager:getMonsterVo01(vo.tid)
    self.mTxtBoss.text = "目标BOSS：" .. vo1.name
    self.mImgBoss:SetImg(UrlManager:getIconPath(vo1.head), true)
end


-- 更新灾害等级栏
function updateDisasterList(self)
    self:recoverListItem()
    for i = 1, 5 do
        local item = SimpleInsItem:create(self:getChildGO("GroupDisasterListItem"), self.mGroupDisaster, "InfiniteCityDisasterListItem")
        item:setText("mTxtDisasterLv", nil, i)
        local vo = infiniteCity.InfiniteCityManager:getDisasterVoByLvl(i)
        item:setText("mTxtScroce", nil, vo:getScore(infiniteCity.InfiniteCityManager.hardLevel) / 1000 .. "K")
        item:setText("mTxtDisasterLab", 27129, "等级")
        item:setText("mTxtScroceLab", 27151, "灾害评分")
        item:getChildGO("mImgAttType"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_type_%s.png", i), false))
        -- item:getChildTrans("mGroupDisasterItem")
        -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(item:getChildTrans("mGroupDisasterItem"))
        self.mDisasterData[i] = item
    end
end
-- 更新灾害等级栏分数
function updateDisasterScore(self)
    if self.mDisasterData then
        for i, item in pairs(self.mDisasterData) do
            local vo = infiniteCity.InfiniteCityManager:getDisasterVoByLvl(i)
            item:setText("mTxtScroce", nil, vo:getScore(infiniteCity.InfiniteCityManager.hardLevel) / 1000 .. "K")
        end
    end
end

-- 回收项
function recoverListItem(self)
    if self.mDisasterData then
        for i, v in pairs(self.mDisasterData) do
            v:poolRecover()
        end
    end
    self.mDisasterData = {}
end

-- 取对应等级的灾害栏父节点
function getDisasterItemParent(self, type)
    return self.mDisasterData[type]:getChildTrans("mGroupDisasterItem")
end

-- 更新灾害显示
function updateDisasterItem(self)
    self:recoverDisasterItem()
    local list = self.mDupData:getDisasterList()
    for i = 1, #list do
        local item = infiniteCity.InfiniteCityDisaterItem:poolGet()
        local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(list[i])
        item:setData(self:getDisasterItemParent(disasterData.type), disasterData)
        table.insert(self.mDisasterItemList, item)
    end
end

-- 回收项
function recoverDisasterItem(self)
    if self.mDisasterItemList then
        for i, v in pairs(self.mDisasterItemList) do
            v:poolRecover()
        end
    end
    self.mDisasterItemList = {}
end

-- 更新灾害选中
function updateDisasterDesList(self)
    self:recoverDesList()
    local list = infiniteCity.InfiniteCityManager.selectDisasterList
    for i = #list, 1, -1 do
        local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(list[i])
        -- local item = SimpleInsItem:create(self:getChildGO("GroupDisasterInfoItem"), self.mScollContent, "InfiniteCityDisasterInfoItem")
        -- item:setText("mTxtLv", nil, disasterData.lvl)
        -- item:setText("mTxtInfo", nil, disasterData:getDes())
        -- table.insert(self.mDisasterDesList, item)
        if self.mDisasterData then
            local item = self.mDisasterData[disasterData.type]
            item:setText("mTxtAttr", nil, disasterData:getDes())
        end
    end
    self:updateLvAndScore()
end
-- 回收项
function recoverDesList(self)
    if self.mDisasterDesList then
        for i, v in pairs(self.mDisasterDesList) do
            v:poolRecover()
        end
    end
    self.mDisasterDesList = {}
end

-- 更新灾害等级和积分
function updateLvAndScore(self)
    local lvl, score = self:getLvAndScore()
    self.mTxtAllLv.text = lvl
    self.mTxtScrore.text = self.mDupData.score + score
end

-- 获取选择的灾害增加的等级和积分
function getLvAndScore(self)
    local lvl = 0
    local score = 0
    local list = infiniteCity.InfiniteCityManager.selectDisasterList
    for i, v in ipairs(list) do
        local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(v)
        lvl = lvl + disasterData.lvl
        score = score + disasterData:getScore(infiniteCity.InfiniteCityManager.hardLevel)
    end
    return lvl, score
end

-- 展示补给选择
function updateSupplyShowList(self)
    self:recoverSupplyShowList()
    local list = infiniteCity.InfiniteCityManager.selectSupplyList
    for i = 1, #list do
        local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(list[i])
        local item = SimpleInsItem:create(self:getChildGO("GroupSupplyShowItem"), self.mGroupSupplyTrans, "InfiniteCitySupplyShowItem")
        -- item:getChildGO("mImgSupplyIcon"):GetComponent(ty.AutoRefImage):SetImg()
        table.insert(self.mSupplyShowList, item)
    end
end
-- 回收项
function recoverSupplyShowList(self)
    if self.mSupplyShowList then
        for i, v in pairs(self.mSupplyShowList) do
            v:poolRecover()
        end
    end
    self.mSupplyShowList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27151):	"灾害评分"
	语言包: _TT(27129):	"等级"
]]
