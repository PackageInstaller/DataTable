--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDupInfoView
@Description    : 无限城副本信息
@date           : 2021-03-02 17:17:02
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityDupInfoView', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityDupInfoView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.skillList = {}
    self.featuresList = {}
    self.mItemList = {}
end

-- 初始化
function configUI(self)
    -- self.mTxtInfo = self:getChildGO('mTxtInfo'):GetComponent(ty.Text)
    -- self.mTxtStageName = self:getChildGO('mTxtStageName'):GetComponent(ty.Text)
    -- self.mTxtTimes = self:getChildGO('mTxtTimes'):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtSourceLab = self:getChildGO('mTxtSourceLab'):GetComponent(ty.Text)
    self.mTxtChoose = self:getChildGO('mTxtChoose'):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO('mTxtTips'):GetComponent(ty.Text)
    self.mTxtHardLv = self:getChildGO('mTxtHardLv'):GetComponent(ty.Text)
    self.mTxtAdd = self:getChildGO('mTxtAdd'):GetComponent(ty.Text)
    self.mTxtLvLab = self:getChildGO('mTxtLvLab'):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO('mTxtLv'):GetComponent(ty.Text)
    self.mTxtSource = self:getChildGO('mTxtSource'):GetComponent(ty.Text)
    self.mTxtSkill = self:getChildGO('mTxtSkill'):GetComponent(ty.Text)
    self.mTxtSkillEn = self:getChildGO('mTxtSkillEn'):GetComponent(ty.Text)
    self.mGroupSkill = self:getChildTrans("mGroupSkill")
    self.mTxtSpecial = self:getChildGO('mTxtSpecial'):GetComponent(ty.Text)
    self.mTxtSpecialEn = self:getChildGO('mTxtSpecialEn'):GetComponent(ty.Text)
    self.mGroupSpecial = self:getChildTrans("mGroupSpecial")

    self.mTxtAward = self:getChildGO('mTxtAward'):GetComponent(ty.Text)
    self.mTxtAwardEn = self:getChildGO('mTxtAwardEn'):GetComponent(ty.Text)
    self.mGroupAward = self:getChildTrans("mGroupAward")

    self.mTxtStamina = self:getChildGO('mTxtStamina'):GetComponent(ty.Text)
    self.mImgStamina = self:getChildGO('mImgStamina'):GetComponent(ty.AutoRefImage)
    self.mGroupCost = self:getChildTrans("mGroupCost")

    self.mBtnFight = self:getChildGO('mBtnFight')
    self.mBtnPass = self:getChildGO('mBtnPass')

    self.mImgLineLvl = self:getChildGO('mImgLineLvl')
    self.mImgLineScore = self:getChildGO('mImgLineScore')

    self.mBtnCustom = self:getChildGO('mBtnCustom')

    self.mBtnChoose = self:getChildGO("mBtnChoose")
    self.mGroupDeff = self:getChildGO("mGroupDeff")
    self.mImgSelect = self:getChildTrans("mImgSelect")

    self.mBtnDeff1 = self:getChildGO("mBtnDeff1")
    self.mBtnDeff2 = self:getChildGO("mBtnDeff2")
    self.mBtnDeff3 = self:getChildGO("mBtnDeff3")
    self.mBtnDeff4 = self:getChildGO("mBtnDeff4")
    self.mBtnDeff5 = self:getChildGO("mBtnDeff5")
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mBtnFight, self.onFightHandler)
    self:addOnClick(self.mBtnCustom, self.onOpenCustom)

    self:addOnClick(self.mGroupDeff, self.onShowDeffChoose)
    self:addOnClick(self.mBtnChoose, self.onShowDeffChoose)
    self:addOnClick(self.mBtnDeff1, self.onDeffChoose1)
    self:addOnClick(self.mBtnDeff2, self.onDeffChoose2)
    self:addOnClick(self.mBtnDeff3, self.onDeffChoose3)
    self:addOnClick(self.mBtnDeff4, self.onDeffChoose4)
    self:addOnClick(self.mBtnDeff5, self.onDeffChoose5)

    self.mTxtLvLab.text = _TT(27135)--"已通关最高灾害等级"
    self.mTxtSourceLab.text = _TT(27136)--"已通关最高评分"
    self.mTxtSkill.text = _TT(27137)--"首领BOSS技能"
    self.mTxtSkillEn.text = _TT(27138)--"BOSS SKILLS"
    self.mTxtSpecial.text = _TT(27139)--"首领BOSS特性"
    self.mTxtSpecialEn.text = _TT(27140)--"BOSS CHARACTERISTIC"
    self.mTxtChoose.text = "灾害选择:"
    self.mTxtTips.text = "灾害会提高关卡难度，请谨慎选择"

    self:setBtnLabel(self.mBtnFight, 27141, "进入备战")
    self:setBtnLabel(self.mBtnPass, 27142, "已通关")

    self:setBtnLabel(self.mBtnChoose, nil, "一级")
    self:setBtnLabel(self.mBtnDeff1, nil, "一级")
    self:setBtnLabel(self.mBtnDeff2, nil, "二级")
    self:setBtnLabel(self.mBtnDeff3, nil, "三级")
    self:setBtnLabel(self.mBtnDeff4, nil, "四级")
    self:setBtnLabel(self.mBtnDeff5, nil, "五级")

    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
end

--非激活
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnFight)
    self:removeOnClick(self.mBtnCustom)

    self:removeOnClick(self.mGroupDeff)
    self:removeOnClick(self.mBtnChoose)
    self:removeOnClick(self.mBtnDeff1)
    self:removeOnClick(self.mBtnDeff2)
    self:removeOnClick(self.mBtnDeff3)
    self:removeOnClick(self.mBtnDeff4)

    self:recoverItem()
    self:recoverFeaturesItem()

    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.onStaminaUpdateHandler, self)
end


function onShowDeffChoose(self)
    if self.mGroupDeff.activeSelf then
        self.mGroupDeff:SetActive(false)
    else
        self.mGroupDeff:SetActive(true)

        self.mImgSelect.gameObject:SetActive(true)
        if infiniteCity.InfiniteCityManager.disasterLevel == 1 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff1.transform)
        elseif infiniteCity.InfiniteCityManager.disasterLevel == 2 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff2.transform)
        elseif infiniteCity.InfiniteCityManager.disasterLevel == 3 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff3.transform)
        elseif infiniteCity.InfiniteCityManager.disasterLevel == 4 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff4.transform)
        elseif infiniteCity.InfiniteCityManager.disasterLevel == 5 then
            gs.TransQuick:LPos(self.mImgSelect, self.mBtnDeff5.transform)
        else
            self.mImgSelect.gameObject:SetActive(false)
        end
        self:updateDeffBtn()
    end
end

function onDeffChoose1(self)
    infiniteCity.InfiniteCityManager.disasterLevel = 1
    self:updateChooseState()
end

function onDeffChoose2(self)
    infiniteCity.InfiniteCityManager.disasterLevel = 2
    self:updateChooseState()
end

function onDeffChoose3(self)
    infiniteCity.InfiniteCityManager.disasterLevel = 3
    self:updateChooseState()
end

function onDeffChoose4(self)
    infiniteCity.InfiniteCityManager.disasterLevel = 4
    self:updateChooseState()
end

function onDeffChoose5(self)
    infiniteCity.InfiniteCityManager.disasterLevel = 5
    self:updateChooseState()
end

function updateChooseState(self, cusInit)
    local str = { "自定义", "一级", "二级", "三级", "四级", "五级" }
    -- local langId = { 27158, 27159, 27160, 27161 }
    if infiniteCity.InfiniteCityManager.disasterLevel == nil then
        -- 第一次
        infiniteCity.InfiniteCityManager.disasterLevel = 1
        cusInit = false
    end
    local lv = infiniteCity.InfiniteCityManager.disasterLevel
    if cusInit then
        lv = self:getDisasterLv()
        infiniteCity.InfiniteCityManager.disasterLevel = lv
    else
        self:updateOneKeyDisaster()
    end

    self:setBtnLabel(self.mBtnChoose, nil, str[lv + 1])
    self.mGroupDeff:SetActive(false)
end

-- 更新一键选择灾害
function updateOneKeyDisaster(self)
    infiniteCity.InfiniteCityManager.selectDisasterList = {}
    local list = self.mDupData:getDisasterList()
    for i = 1, #list do
        local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(list[i])
        if disasterData.lvl == infiniteCity.InfiniteCityManager.disasterLevel then
            infiniteCity.InfiniteCityManager:setSelectDisasterList(list[i])
        end
    end
end

-- 获取自定义的灾害等级（0为自定义）
function getDisasterLv(self)
    local list = infiniteCity.InfiniteCityManager.selectDisasterList
    if #list < 5 then
        return 0
    end
    local tempLv = nil
    for i = #list, 1, -1 do
        local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(list[i])
        if not tempLv then
            tempLv = disasterData.lvl
        end
        if tempLv ~= disasterData.lvl then
            return 0
        end
    end
    return tempLv
end


function updateDeffBtn(self)
    local disasterLevel = infiniteCity.InfiniteCityManager.disasterLevel
    local selectStr = "<color='#000000'>%s</color>"
    local nomalStr = "<color='#ffffff'>%s</color>"
    self:setBtnLabel(self.mBtnDeff1, nil, disasterLevel == 1 and string.format(selectStr, "一级") or string.format(nomalStr, "一级"))
    self:setBtnLabel(self.mBtnDeff2, nil, disasterLevel == 2 and string.format(selectStr, "二级") or string.format(nomalStr, "二级"))
    self:setBtnLabel(self.mBtnDeff3, nil, disasterLevel == 3 and string.format(selectStr, "三级") or string.format(nomalStr, "三级"))
    self:setBtnLabel(self.mBtnDeff4, nil, disasterLevel == 4 and string.format(selectStr, "四级") or string.format(nomalStr, "四级"))
    self:setBtnLabel(self.mBtnDeff5, nil, disasterLevel == 5 and string.format(selectStr, "五级") or string.format(nomalStr, "五级"))
end


-- 体力更新
function onStaminaUpdateHandler(self)
    self:updateCost()
end
-- 恢复显示
function reShow(self)
    self:updateChooseState(true)
end

function show(self, parent, cusDupId)
    self:setParentTrans(parent)
    self:setData(cusDupId)
    self:updateChooseState(true)
end

function setData(self, cusDupId)
    self.mId = cusDupId

    local langId = { 27158, 27159, 27160, 27161 }
    self.mTxtHardLv.text = string.substitute("当前难度：{0}", _TT(langId[infiniteCity.InfiniteCityManager.hardLevel]))
    self.mTxtAdd.text = string.substitute("灾害平分加成：{0}%", infiniteCity.InfiniteCityManager.hardLevel * 100)

    self.mDupData = infiniteCity.InfiniteCityManager:getDupBaseData(cusDupId)
    self.mTxtName.text = self.mDupData.name
    -- self.mTxtStageName.text = self.mDupData:getName()
    -- self.mTxtInfo.text = self.mDupData:getDescribe()
    if not self.mDupData.topDisasterLv or self.mDupData.topDisasterLv == 0 then
        self.mTxtLv.text = ""
        self.mImgLineLvl:SetActive(true)
    else
        self.mImgLineLvl:SetActive(false)
        self.mTxtLv.text = self.mDupData.topDisasterLv
    end
    if not self.mDupData.topScore or self.mDupData.topScore == 0 then
        self.mTxtSource.text = ""
        self.mImgLineScore:SetActive(true)
        self.mTxtAward.text = "首通奖励"--_TT()
        self.mTxtAwardEn.text = "REWARD FIRST"--_TT()
    else
        self.mImgLineScore:SetActive(false)
        self.mTxtSource.text = self.mDupData.topScore
        self.mTxtAward.text = "奖励预览"--_TT(116)
        self.mTxtAwardEn.text = "REWARD PREVIEW"--_TT()
    end

    if self.mDupData.isPass == 1 then
        self.mBtnFight:SetActive(false)
        self.mBtnPass:SetActive(true)
    else
        self.mBtnFight:SetActive(true)
        self.mBtnPass:SetActive(false)
    end

    -- self:updateSkill()
    -- self:updateFeatures()
    self:updateAward()
    self:updateCost()
end
-- boss技能
function updateSkill(self)
    self:recoverItem()
    local list = {}
    for i, v in ipairs(self.mDupData:getBossSkillList()) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        if skillVo:getType() ~= 0 then
            table.insert(list, v)
        end
    end
    for i, v in ipairs(list) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        local item = SimpleInsItem:create(self:getChildGO("GroupSkillItem"), self.mGroupSkill, "InfiniteCityBossSkillItem")
        item:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()))
        item:addUIEvent("mGroup", function()
            TipsFactory:skillTips(nil, v, nil, true)
        end)
        table.insert(self.skillList, item)
    end
end
-- 回收项
function recoverItem(self)
    if self.skillList then
        for i, v in pairs(self.skillList) do
            v:poolRecover()
        end
    end
    self.skillList = {}
end

-- boss特性
function updateFeatures(self)
    self:recoverFeaturesItem()
    for i, v in ipairs(self.mDupData:getFeaturesList()) do
        local item = SimpleInsItem:create(self:getChildGO("GroupSpecialItem"), self.mGroupSpecial, "InfiniteCityBossSpecialItem")
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%d.png", 52 + v[1])))
        item:setText("mTxtInfo", v[2], "")
        table.insert(self.featuresList, item)
    end
end
-- 回收项
function recoverFeaturesItem(self)
    if self.featuresList then
        for i, v in pairs(self.featuresList) do
            v:poolRecover()
        end
    end
    self.featuresList = {}
end

function updateAward(self)
    self:recoverAwardItem()
    local list = self.mDupData.topScore > 0 and self.mDupData.showDrop or self.mDupData.firstAward
    if dup.DupMainManager:getIsMatchActivityMoney(PreFightBattleType.InfiniteCity) and self.mDupData.topScore <= 0 then
        local propVo = props.PropsManager:getPropsVo({ tid = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP), num = self.mDupData.needNum })
        propVo.state = 3
        table.insert(list, propVo)
    end
    for i, vo in ipairs(list) do
        local propsGrid = PropsGrid:create(self.mGroupAward, { vo.tid, (vo.num or vo.count) }, 0.75)
        if vo.state and vo.state == 3 then
            propsGrid:setIsDeadline(true)
        end
        table.insert(self.mItemList, propsGrid)
    end
end
-- 回收项
function recoverAwardItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}
end

-- 更新消耗
function updateCost(self)
    self.mImgStamina:SetImg(UrlManager:getPropsIconUrl(self.mDupData.needTid), false)

    local color = ColorUtil.WHITE_NUM
    if not MoneyUtil.judgeNeedMoneyCountByType(MoneyType.ANTIEPIDEMIC_SERUM_TYPE, self.mDupData.needNum, false, false) then
        color = ColorUtil.RED_NUM
    end
    self.mTxtStamina.text = HtmlUtil:color(self.mDupData.needNum, color)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupCost)--立即刷新
end

function onOpenCustom(self)
    stamina.StaminaManager:checkStamina(PreFightBattleType.InfiniteCity, nil, self.mDupData.needNum, function()
        GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_PREP_PANEL, self.mId)
        -- self:onCloseHandler()
    end, self)
end

function onFightHandler(self)
    self:onCloseHandler()
    GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_CITY_PREP, { cityId = self.mId })
end

function onCloseHandler(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_INFINITE_CITY_DUP_INFO_PANEL)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]