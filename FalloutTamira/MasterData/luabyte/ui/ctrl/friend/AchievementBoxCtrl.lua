local friendView = require("UI.View.Friend.BaseFriendItemView")
local PageApplyCtrl = BaseClass("PageApplyCtrl", BaseUICtrl)
local M = PageApplyCtrl



function M:Show(id, data, num)
    self._data = data
    self._num = num
    self._firendId = id
    self._isFriend = id > 0
    self._view.num:SetText(tostring(num))
    self:_RefreshAchievement()
end


function M:_RefreshAchievement()
    for i=1,3 do
        local item = self._data[i]
        local nullName = string.format("null%d", i)
        local showName = string.format("show%d", i)
        
        self._view[nullName]:SetActive(item == nil)
        self._view[showName]:SetActive(item ~= nil)

        if item then
            local cfg = ConfigHelper.GetCfg("achievementGroup", item.Id) 
            local level = 1

            for i,v in ipairs(cfg.upIntegral) do
                if item.Score >= v then
                    level = i
                end
            end

            self._view[showName]:SetPic(cfg.icon[level])
        end
    end
end


function M:__init(view)
    self._data = {}
    self._view = view 
    self._view.editBtn:onClick(Bind(self, self._OnClickEditBtn))
end


function M:_OnClickEditBtn()
    if self._isFriend then
        FriendDataMgr:GetInstance():SendRequsetFriendAchievements(self._firendId, Bind(self, self._OnCallBack))
        return
    end

    UIContextMgr:GetInstance():Show("AchievementSelect", self._data, false, Bind(self, self._RefreshBox))
end


function M:_OnCallBack(msgData)
    local data = {}
    
    for i,v in ipairs(msgData) do
        local item = v;
        item.FriendId = self._firendId
        table.insert(data, item)
    end

    UIContextMgr:GetInstance():Show("AchievementSelect", data, true, nil)
end


function M:_RefreshBox(data)
    if data then
        self._data = data
    end

    self:_RefreshAchievement()
end




return PageApplyCtrl