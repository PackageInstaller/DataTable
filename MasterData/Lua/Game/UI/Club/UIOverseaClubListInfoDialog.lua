-------------------------------------------------------------------------------
-- 社团 - 社团列表介绍界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-06 11:01:46
-------------------------------------------------------------------------------

local DeviceID = CS.Engine.Http.DeviceID

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubOverallInformationAddDialog.prefab > name: OverseaClubOverallInformationAddDialog
---@class UIOverseaClubListInfoDialog
---@field Env                           	UIOverseaClubListInfoDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field EmptyArea                     	UnityEngine.RectTransform               	@ 1    空白区域
---@field clubHeadImg                   	UnityEngine.RectTransform               	@ 2    社团头像图片
---@field clubNameTxt                   	UnityEngine.RectTransform               	@ 3    社团名字文本
---@field clubIdTxt                     	UnityEngine.RectTransform               	@ 4    社团id文本
---@field clubIdCopyBtn                 	UnityEngine.RectTransform               	@ 5    社团id复制按钮
---@field clubLevelTxt                  	UnityEngine.RectTransform               	@ 6    社团等级文本
---@field clubExpTxt                    	UnityEngine.RectTransform               	@ 7    社团经验文本
---@field clubExpSlider                 	UnityEngine.UI.Slider                   	@ 8    社团经验滑块
---@field memberNumTxt                  	UnityEngine.RectTransform               	@ 9    成员数量文本
---@field applyInfoTxt                  	UnityEngine.RectTransform               	@ 10   申请信息文本呢
---@field noticeScrollView              	UnityEngine.RectTransform               	@ 11   公告滚动节点
---@field noticeContentTxt              	UnityEngine.RectTransform               	@ 12   公告内容文本
local UIOverseaClubListInfoDialog = Class('UIOverseaClubListInfoDialog')


function UIOverseaClubListInfoDialog:__init()
    ---@type ClubListUnitDojo @ 社团列表单元信息
    self.clubListUnitDojo_ = nil
end


function UIOverseaClubListInfoDialog:__delete()
    self.clubListUnitDojo_ = nil
end


function UIOverseaClubListInfoDialog:Awake()
    SetButtonAction(self.EmptyArea, Bind(self, self.OnClickEmptyAreaHandler_))
    SetButtonAction(self.clubIdCopyBtn, Bind(self, self.OnClickCopyClubIdButtonHandler_))
end


function UIOverseaClubListInfoDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        self.clubListUnitDojo_ = initParams.clubListUnitDojo
        self:UpdateClubListUnitInfo_()
    end)
end


function UIOverseaClubListInfoDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function UIOverseaClubListInfoDialog:UpdateClubListUnitInfo_()
    ---@type ClubListUnitDojo
    local unitDojo = checkTable(self.clubListUnitDojo_)
    --TODO

    -- update head
    local clubHeadVo = ClubUtils.GetClubHeadVo(unitDojo.avatar)
    if clubHeadVo.photoPath then
        CfUtils.FillImage(self.clubHeadImg, clubHeadVo.photoPath)
    end
    
    -- update name
    CfUtils.FillText(self.clubNameTxt, tostring(unitDojo.name))

    -- update clubId
    CfUtils.FillText(self.clubIdTxt, tostring(unitDojo.clubId))

    -- update level
    local clubLevel = checkInt(unitDojo.level)
    CfUtils.FillText(self.clubLevelTxt, clubLevel)

    if clubLevel >= ClubUtils.GetLevelMax() then
        CfUtils.FillText(self.clubExpTxt, '')
        CfUtils.SetSliderPercent(self.clubExpSlider, 1)
    else
        local curtTotalExp  = ClubUtils.GetLevelExp(clubLevel)
        local nextTotalExp  = ClubUtils.GetLevelExp(clubLevel + 1)
        local curtProgress  = math.max(checkInt(unitDojo.contributionPoint) - curtTotalExp, 0)
        local totalProgress = math.max(nextTotalExp - curtTotalExp)
        CfUtils.FillText(self.clubExpTxt, string.fmt('%1/%2', curtProgress, totalProgress))
        CfUtils.SetSliderPercent(self.clubExpSlider, curtProgress / totalProgress)
    end

    -- update members
    local clubLevelVo = ClubUtils.GetLevelVo(clubLevel)
    CfUtils.FillText(self.memberNumTxt, string.fmt('%1/%2', checkInt(unitDojo.members), checkInt(clubLevelVo.members)))

    -- update apply info
    local applyLevel = unitDojo.applyLevel
    local isFreeType = unitDojo.applyType == ClubUtils.ApplyType.FREE
    local applyText  = ''
    if isFreeType then
        applyText = localize('_num_级以上，自由加入', {_num_ = applyLevel})
    else
        applyText = localize('_num_级以上，需要审核', {_num_ = applyLevel})
    end
    CfUtils.FillText(self.applyInfoTxt, applyText)

    -- update notice
    local clubNoticeText = string.isEmpty(unitDojo.notice) and localize('欢迎加入~') or unitDojo.notice
    CfUtils.FillText(self.noticeContentTxt, clubNoticeText)
end


-------------------------------------------------
-- handler

function UIOverseaClubListInfoDialog:OnClickEmptyAreaHandler_()
    CfUtils.DialogClose(self.controller)

    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    local clubHeadVo = ClubUtils.GetClubHeadVo(clubHomeDojo.avatar)
    CfUtils.FillImage(self.clubHeadImg, clubHeadVo.photoPath)
end


function UIOverseaClubListInfoDialog:OnClickCopyClubIdButtonHandler_()
    GameUtils.SecondConfirm(localize("是否复制【社团ID】到剪切板？"), function()
        ---@type ClubListUnitDojo
        local unitDojo = checkTable(self.clubListUnitDojo_)
        DeviceID.CopyToClipboard(tostring(unitDojo.clubId))
        GameUtils.Toast(localize("社团ID已复制"))
    end)
end


return UIOverseaClubListInfoDialog
