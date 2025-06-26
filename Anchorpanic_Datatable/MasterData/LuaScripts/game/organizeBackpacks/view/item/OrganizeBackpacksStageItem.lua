local eventname = require("game.event.EventName")
--[[
-----------------------------------------------------
@filename       : organizeBackpacks
@Description    : 活动玩法整理背包关卡Item
@date           : 2024/9/24 11:52
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------]]
module("organizeBackpacks.OrganizeBackpacksStageItem ", Class.impl("lib.component.BaseItemRender"))

--构造函数
function ctor(self)
    super.ctor(self)
end

function onInit(self, go)
    super.onInit(self, go)
    self.mClick = self:getChildGO("mClick")
    self.mImgRed = self:getChildGO("mImgRed")
    self.mGroup = self:getChildTrans("mGroup")
    self.mImgPass = self:getChildGO("mImgPass")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgLine = self:getChildTrans("mImgLine")
    self.GroupOpenTip = self:getChildGO("GroupOpenTip")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtOpenTip = self:getChildGO("mTxtOpenTip"):GetComponent(ty.Text)
    self.mImgStageBg = self:getChildGO("mImgStageBg"):GetComponent(ty.AutoRefImage)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mClick, self.onClickHandler)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_ORGANIZE_BACKPACKS_DUP_SHOW_INFO, self.updateSelectState, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ORGANIZE_BACKPACKS_DUP_SHOW_INFO, self.updateSelectState, self)
    self.mImgSelect:SetActive(false)
end

--纯设置数据
function setData(self, param)
    super.setData(self, param)
    self.mData = organizeBackpacks.OrganizeBackpacksManager:getStageVoById(self.data)
    self.mImgPass:SetActive(self.mData:getIsPass())

    self.mImgStageBg:SetImg(UrlManager:getPackPath("organizeBackpacks/organizeBackpacks_level_0"..self.mData:getType() .. ".png"), true)
    local PosY = self:getNewPosY(self.mData:getId() % 2 == 0)
    local scaleY = self.mData:getId() % 2 == 0 and 1 or - 1
    self.mImgLine.gameObject:SetActive(self.mData:getId() % 10 ~= 1)
    gs.TransQuick:Scale(self.mImgLine, 1, scaleY, 1)
    gs.TransQuick:UIPosY(self.mGroup, PosY)

    if self.mData:getIsTimeOpen() and self.mData:getIsOpen() then
        self.GroupOpenTip:SetActive(false)
    else
        self.GroupOpenTip:SetActive(true)
    end

    if not self.mData:getIsTimeOpen() then
        local data = TimeUtil.getTimeTable(self.mData.startTime)
        local str = string.format("%02d/%02d %02d:%02d%s", data.month, data.day, data.hour, data.min, _TT(92026))
        self.mTxtOpenTip.text = str
        self.mTxtName.text = ""
    elseif not self.mData:getIsOpen() then
        self.mTxtOpenTip.text = _TT(42105)
        self.mTxtName.text = ""
    else
        self.mTxtOpenTip.text = ""
        self.mTxtName.text = self.mData:getName()
    end

    self.mImgRed:SetActive(self.mData:getIsTimeOpen() and self.mData:getIsOpen() and not StorageUtil:getBool1(gstor.ORGANIZEBACKPACKS_DUPNEWOPENSTR .. self.mData.id))
end

-- 点击回调
function onClickHandler(self)
    if not self.mData:getIsTimeOpen() then
        gs.Message.Show(TimeUtil.getFormatTimeBySeconds_7(self.mData.startTime) .. _TT(92026))
        return
    end

    if not self.mData:getIsOpen() then
        gs.Message.Show(_TT(42105))
        return
    end

    StorageUtil:saveBool1(gstor.ORGANIZEBACKPACKS_DUPNEWOPENSTR .. self.mData.id, true)
    self.mImgRed:SetActive(self.mData:getIsTimeOpen() and self.mData:getIsOpen() and not StorageUtil:getBool1(gstor.ORGANIZEBACKPACKS_DUPNEWOPENSTR .. self.mData.id))

    GameDispatcher:dispatchEvent(EventName.UPDATE_ORGANIZE_BACKPACKS_DUP_SHOW_INFO, self.mData:getId())
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

--更新选中状态

function updateSelectState(self, dupId)
    self.mImgSelect:SetActive((dupId and self.mData:getId() == dupId))
end
function getNewPosY(self, isDown)
    return isDown and - 73.0 or 82.0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
