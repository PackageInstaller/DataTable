local AchievementSelectPopupCtrl = BaseClass("AchievementSelectPopupCtrl",BaseUICtrl)
local M = AchievementSelectPopupCtrl


function M:OnEnter(curList, data, callback, isFriend)
    self._isFriend = isFriend
    self._callBack = callback
    self._curList = curList
    self._data = data
    self:_OnClickType(0)
    self._view.save:SetActive(not self._isFriend)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:_SelectItem(id, score, callback)
    local key = MapUtil.FindKey(self._curList, function (v) return v.Id == id end)

    if key then
        self:_RemoveData(key, callback)
        return
    end
    
    if #self._curList > 2 then
        return
    end

    self:_AddData(id, score, callback)
end


function M:_RemoveData(key, callback)
    table.remove(self._curList, key)
    self._callBack(self._curList)
    callback(1)
end


function M:_AddData(id, score, callback)
    local data = {
        Id = id,
        Score = score
    }
    table.insert(self._curList, data)
    self._callBack(self._curList)
    callback(0)
end


function M:Init()
    self.m_Text = {1240, 1241, 1242, 1243}

    self._view.saveBtn:onClick(Bind(self, self._OnClickSave))
    self._view.selectBtn:onClick(Bind(self, self._OnClickContent))
    self._view.closeBtn:onClick(Bind(self, self._OnClickBack))
    self._view.closeLv:onClick(Bind(self, self._OnClickCloseContent))

    for i=0,3 do
        local viewName = string.format("lv%d", i)
        self._view[viewName]:onClick(Bind(self, self._OnClickType, i))
    end

    self._view.scrollView:Init(require("UI.Ctrl.Achievement.AchievementSelectItemCtrl"), require("UI.View.Achievement.AchievementSelectItemView"))
    self._view.scrollView:SetCreateItemCallback(Bind(self, self._OnCreateItem))
end


function M:_OnCreateItem(item)
    if self._isFriend then
        return
    end

    item:ClickToggleCallback(Bind(self, self._SelectItem))
end


function M:_OnClickSave()
    AchievementDataMgr:GetInstance():SendRequestAchievementShow(self._curList)
    self:Close()
end


function M:_OnClickContent()
    self._view.content:SetActive(true)
end


function M:_OnClickCloseContent()
    self._view.content:SetActive(false)
end


function M:_OnClickType(index)
    local data = self._data

    if index > 0 then
        data = MapUtil.FilterValues(self._data, function (v)
            local level = self._isFriend and v.Level or v:Level()
            return level == index + 1
        end)
    else
        data = MapUtil.FilterValues(self._data, function (v)
            local level = self._isFriend and v.Level or v:Level()
            return level > index + 1
        end)
    end

    self._view.text:SetText(self.m_Text[index + 1])
    self._view.scrollView:SetDataList(data)
    self._view.NoneTips:SetActive(#data==0)
    self:_OnClickCloseContent()
end


function M:_OnClickBack()
    if self._callBack then
        if self._isFriend then
            self._callBack()
        else 
            local info = AchievementDataMgr:GetInstance():AchievementInfoData()
            self._callBack(info)
        end
    end
    
    self:Close()
end



return AchievementSelectPopupCtrl