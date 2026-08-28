-------------------------------------------------------------------------------
-- 社团 - 社团公告修改弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-20 20:12:23
-------------------------------------------------------------------------------

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubModifyNoticePopup.prefab
---@class UIOverseaClubModifyNoticePopup
---@field Env                           	UIOverseaClubModifyNoticePopup          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field modifyBtn                     	UnityEngine.RectTransform               @ 修改按钮
---@field noticeField                   	UnityEngine.UI.InputField               @ 名字输入框
---@field closeBtn                      	UnityEngine.RectTransform               @ 关闭按钮
---@field backBlock                     	UnityEngine.RectTransform               @ 空白区
local UIOverseaClubModifyNoticePopup = Class('UIOverseaClubModifyNoticePopup')


function UIOverseaClubModifyNoticePopup:__init()
end


function UIOverseaClubModifyNoticePopup:__delete()
end


function UIOverseaClubModifyNoticePopup:Awake()
    SetButtonAction(self.closeBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.modifyBtn, Bind(self, self.OnClickModifyButtonHandler_))
end


function UIOverseaClubModifyNoticePopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- set noticeField limit
        local noticeLimitMax = ClubUtils.GetParamValue(ClubUtils.ParamsId.NOTICE_LENGTH)
        self.noticeField.characterLimit = noticeLimitMax

        -- set noticeField placeholder
        CfUtils.FillCfText(self.noticeField.placeholder, localize('欢迎加入~'))

        -- set clubName
        local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
        self:SetInputClubNotice(clubHomeDojo.notice)
    end)
end


function UIOverseaClubModifyNoticePopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return string
function UIOverseaClubModifyNoticePopup:GetInputClubNotice()
    return checkString(self.noticeField.text)
end
function UIOverseaClubModifyNoticePopup:SetInputClubNotice(clubNotice)
    self.noticeField.text = checkString(clubNotice)
end


-------------------------------------------------
-- handler

function UIOverseaClubModifyNoticePopup:OnClickCloseButtonHandler_()
    CfUtils.DialogClose(self.controller)
end


function UIOverseaClubModifyNoticePopup:OnClickModifyButtonHandler_()
    -- 修改社团公告
    local requestData = {notice = self:GetInputClubNotice()}
    GameUtils.Request(Interfaces.OverseaClubUpdateNotice, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()

            -- update homeDojo
            clubHomeDojo.notice = requestData.notice

            -- change notice 
            Events.Broadcast(ClubUtils.EventName.UPDATE_NOTICE)
            GameUtils.Toast(localize('社团公告更新成功'))
            CfUtils.DialogClose(self.controller)
        end
    end)
end


return UIOverseaClubModifyNoticePopup
