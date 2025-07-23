--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksDupView
@Description    : 整理背包关卡界面
@date           : 2024-9-20 17:04:00
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module("organizeBackpacks.OrganizeBackpacksDupView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("organizeBackpacks/OrganizeBackpacksDupView.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("整理箱包")
    self:setUICode(LinkCode.OrganizeBackpacks)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mSelectStageId = nil
    self.mSelectDupType = nil
    self.mPropsItems = {}
    self.mStageDupItemDic = {}
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mClickHide = self:getChildGO("mClickHide")
    self.mGroupRight = self:getChildGO("mGroupRight")
    self.mBtnChallenge = self:getChildGO("mBtnChallenge")
    self.mStageDupItem = self:getChildGO("mStageDupItem")
    self.mStageDupGroup = self:getChildTrans("mStageDupGroup")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildTrans("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTargetDes = self:getChildTrans("mTxtTargetDes"):GetComponent(ty.Text)
    self.mTextAwardTitle = self:getChildTrans("mTextAwardTitle"):GetComponent(ty.Text)
    self.mTextTargetTitle = self:getChildTrans("mTextTargetTitle"):GetComponent(ty.Text)
    self.mScrollerStageList = self:getChildGO("ScrollerStageList"):GetComponent(ty.LyScroller)
    self.mScrollerStageList:SetItemRender(organizeBackpacks.OrganizeBackpacksStageItem)

    self.mGroupRightAni = self.mGroupRight:GetComponent(ty.Animator)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ORGANIZE_BACKPACKS_DUP_SHOW_INFO, self.updateStageShowInfo, self)
    self:updateView()

end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_ORGANIZE_BACKPACKS_DUP_SHOW_INFO, self.updateStageShowInfo, self)

    self.mGroupRight:SetActive(false)

    self.mSelectStageId = nil
    self.mSelectDupType = nil
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnChallenge, 27, "挑战")

end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickHideHandler)
    self:addUIEvent(self.mBtnChallenge, self.onClickHandler)
    self:addUIEvent(self.mClickHide, self.onClickHideHandler)
end

function updateView(self)
    self:clearDupItem()
    local list = organizeBackpacks.OrganizeBackpacksManager:getTypeList()
    for i, v in ipairs(list) do
        local item = SimpleInsItem:create(self.mStageDupItem, self.mStageDupGroup, "organizeBackpacksDupItem"..v:getId())
        item:addUIEvent("mClick", function ()
            if v:getIsTimeOpen() then
                self:updateStateDupItemState(v:getId())
                return
            end
        end)
        item:getChildGO("mTxtOpenTip"):GetComponent(ty.Text).text = "未开启"
        item:getChildGO("mTxtName"):SetActive(v:getIsTimeOpen())
        item:getChildGO("mImgOpenTip"):SetActive(not v:getIsTimeOpen())
        item:getChildGO("mTxtName"):GetComponent(ty.Text).text = v:getName()
        item:getChildGO("mImgSelect"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("organizeBackpacks/organizeBackpacks_Lock_0"..v:getId() .. ".png"), true)
        self.mStageDupItemDic[v:getId()] = item
    end

    self:updateStateDupItemState(1)

    self:refreshTypeRed()
end

function refreshTypeRed(self)
    local list = organizeBackpacks.OrganizeBackpacksManager:getTypeList()
    for i, v in ipairs(list) do
        local item = self.mStageDupItemDic[v:getId()]
        if item then
            item:getChildGO("mImgRed"):SetActive(organizeBackpacks.OrganizeBackpacksManager:getTypeRedState(v:getId()))
        end
    end
end

function updateStageShowInfo(self, stageId)
    if (self.mSelectStageId and self.mSelectStageId == stageId) or (not stageId) then
        return
    end

    if not self.mGroupRight.activeSelf then
        self.mGroupRight:SetActive(true)
    else
        self.mGroupRightAni:SetTrigger("show")
    end

    self.mSelectStageId = stageId

    local stageVo = organizeBackpacks.OrganizeBackpacksManager:getStageVoById(stageId)
    self.mTxtTitle.text = stageVo:getName()
    self.mTxtTargetDes.text = stageVo:getDesc()

    self:clearItems()
    for _, v in ipairs(stageVo:getAwardList()) do
        local propsGrid = PropsGrid:createByData({tid = v.tid, num = v.num, parent = self:getChildTrans("Content"), scale = 1, showUseInTip = true})
        propsGrid:setIconGray(stageVo:getIsPass() == true)
        propsGrid:setHasRec(stageVo:getIsPass() == true)
        table.insert(self.mPropsItems, propsGrid)
    end

    self:refreshTypeRed()
end

function clearItems(self)
    if #self.mPropsItems > 0 then
        for i, item in ipairs(self.mPropsItems) do
            item:poolRecover()
            item = nil
        end
        self.mPropsItems = {}
    end
end

function onClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_PANEL, self.mSelectStageId)
    self:close()
end

function onClickHideHandler(self)
    if self.mGroupRight.activeSelf then
        self.mGroupRightAni:SetTrigger("exit")
        local time = AnimatorUtil.getAnimatorClipTime(self.mGroupRightAni, "mGroupRight_Exit")
        self:setTimeout(time, function ()
            self.mGroupRight:SetActive(false)
        end)

        self.mSelectStageId = nil
        GameDispatcher:dispatchEvent(EventName.UPDATE_ORGANIZE_BACKPACKS_DUP_SHOW_INFO)
    end
end

function updateStageList(self, dupType)
    local list = organizeBackpacks.OrganizeBackpacksManager:getTypeStageList(dupType)

    if self.mScrollerStageList.Count <= 0 then
        self.mScrollerStageList.DataProvider = list
    else
        self.mScrollerStageList:ReplaceAllDataProvider(list)
    end
end

function updateStateDupItemState(self, dupType)
    if self.mSelectDupType and self.mSelectDupType == dupType then
        return
    end
    self.mSelectDupType = dupType
    self.mSelectStageId = nil
    for id, item in pairs(self.mStageDupItemDic) do
        item:getChildGO("mImgSelect"):SetActive(id == dupType)
    end
    self:updateStageList(dupType)
    self.mImgBg:SetImg(UrlManager:getBgPath("organizeBackpacks/organizeBackpacks_bg_0"..dupType..".jpg"), true)
end

function clearDupItem(self)
    if table.nums(self.mStageDupItemDic) > 0 then
        for _, item in pairs(self.mStageDupItemDic) do
            item:poolRecover()
            item = nil
        end
        self.mStageDupItemDic = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
