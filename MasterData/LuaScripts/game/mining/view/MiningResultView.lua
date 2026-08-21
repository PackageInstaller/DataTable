--[[ 
-----------------------------------------------------
@filename       : MiningResultView
@Description    : 挖矿结算
@date           : 2023-12-11 14:37:04
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.MiningResultView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mining/MiningResultView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
isAddMask = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:initData()
end
--析构  
function dtor(self)
end

function initData(self)
    self.mStarItemList = {}
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO("aa"):GetComponent(ty.Image)
    -- self.bb = self:getChildTrans("bb")
    self.mGroupAward = self:getChildTrans("mGroupAward")

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mImgNewRecord = self:getChildGO("mImgNewRecord")
    self.mGroupStar = self:getChildTrans("mGroupStar")
    self.mTextFinalScore = self:getChildGO("mTextFinalScore"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.dupVo = args.dupVo

    self:updateView()
    GameDispatcher:dispatchEvent(EventName.REQ_MINING_PASS, self.dupVo.id)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    mining.MiningManager.currScore = 0
    mining.MiningManager.currWave = 1
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)

    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnFight, self.onOver_Again)
end

function onExit(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.CLOSE_MINING_SCENE)
end

function onOver_Again(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.SEND_MINING_REPLAY, { dupId = self.dupVo.id })
end

function updateView(self)

    local score = mining.MiningManager.currScore
    self.mTextFinalScore.text = score

    local oldRecord = mining.MiningManager:getPlayerDupRecord(self.dupVo.id)
    self.mImgNewRecord:SetActive(score > oldRecord)

    local starCount = mining.MiningManager:getPlayerDupStar(self.dupVo.id, score)
    for i = 1, 3 do
        self:getChildGO("mImgStar_" .. i):SetActive(starCount >= i)
    end

    self:updateStarInfo()
    self:updateAward()
end

function updateAward(self)
    self:clearItem()
    local oldRecord = mining.MiningManager:getPlayerDupRecord(self.dupVo.id)
    --是否首通
    if oldRecord == 0 and mining.MiningManager.currScore > 0 then
        local awardList = self.dupVo.firstAward

        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({ tid = awardList[i].tid, num = awardList[i].num, parent = self.mGroupAward })
            propsGrid:setHasRec(false)
            propsGrid:setIsFirstPass(true)
            table.insert(self.mPropsGridList, propsGrid)
        end
        self.mGroupAward.gameObject:SetActive(true)
    else
        self.mGroupAward.gameObject:SetActive(false)
    end
end

function clearItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

-- 更新星级
function updateStarInfo(self, args)
    local list = self.dupVo.starList
    local score = mining.MiningManager.currScore
    local starCount = mining.MiningManager:getPlayerDupStar(self.dupVo.id, score)
    self:recoverStarItem()
    for i = 1, #list do
        local item = SimpleInsItem:create(self:getChildGO("GroupTaskItem"), self.mGroupStar, "MiningResultViewStarItem")
        local starConfig = mining.MiningManager:getStarConfigVo(list[i])

        local isMeet = starCount >= starConfig.star
        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end
        item:getChildGO("mImgStar"):SetActive(isMeet)
        item:setText("mTextDesc", nil, string.format("<color=#%s>%s</color>", color, _TT(starConfig.des)))

        table.insert(self.mStarItemList, item)
    end
end

function recoverStarItem(self)
    for k, v in pairs(self.mStarItemList) do
        v:poolRecover()
    end
    self.mStarItemList = {}
end



return _M