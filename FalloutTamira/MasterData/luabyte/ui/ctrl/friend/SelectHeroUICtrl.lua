local SelectHeroUICtrl = BaseClass("SelectHeroUICtrl", BaseUICtrl)
local M = SelectHeroUICtrl
local tInsert = table.insert



function M:OnEnter(index, heroIds, callback)
    self._index = index
    self._selectHeroId = {}
    self._callback = callback
    self:FitData(heroIds)
    self:_OnClickHeroType(1)
end


function M:UpdateItem(obj, index)
    local heroItem = obj:GetHeroHeadItem()
    local heroId = self._heros[index]:GetHeroId()
    local lv = self._heros[index]:GetLevel()
    local select = self:_ItemIsSelect(heroId)
    heroItem.select = select
    heroItem:SetHeroId(heroId)
    heroItem:SetHeroLevel(lv)
    heroItem:onClick(Bind(self, self._OnClickItem, self._heros[index]:GetHeroId())) 
end


function M:FitData(heroIds)
    for _,v in ipairs(heroIds) do
        tInsert(self._selectHeroId, v)
    end
end


function M:_ShowList()
    self._view.looplist:ShowList(#self._heros)
    self._view.animDelay:InitStart()
end


function M:_ItemIsSelect(heroId)
    local select = false

    if self._index == 0 then
        select = MapUtil.Find(self._selectHeroId, function (v) return v == heroId end)
        select = select ~= nil
    else
        select = self._selectHeroId[self._index] == heroId
    end

    return select
end


function M:_FitData(data)
    self._heros = {}

    for i = 0, data.Count - 1 do
        tInsert(self._heros, data[i])
    end

    table.sort(self._heros, function (v1, v2)
        local id1 = v1:GetHeroId()
        local id2 = v2:GetHeroId()
        local lv1 = v1:GetLevel()
        local lv2 = v2:GetLevel()
        local k1 = (MapUtil.FindKey(self._selectHeroId, function (v) return v == id1 end) or 99)
        local k2 = (MapUtil.FindKey(self._selectHeroId, function (v) return v == id2 end) or 99)

        if k1 == k2 then
            if lv1 ~= lv2 then
                return lv1 > lv2
            end

            return id1 > id2
        end

        if self._index == 0 then
            return k1 < k2
        else
            local s1 = k1 == self._index and 0 or 99
            local s2 = k2 == self._index and 0 or 99
            if s1 == s2 then
                return k1 > k2
            end

            return s1 < s2
        end
    end)
end


function M:_SelectHeroId(heroId, curKey)
    if curKey ~= nil and curKey ~= self._index then
        GameHelper.TipsById(4180)
        return
    end

    self._selectHeroId[self._index] = self._selectHeroId[self._index] == heroId and 0 or heroId
end


function M:_SelectHeroIds(heroId, curKey)
    if curKey ~= nil then
        self._selectHeroId[curKey] = 0
        return
    end

    for i,v in ipairs(self._selectHeroId) do
        if v == 0 then
            self._selectHeroId[i] = heroId
            return
        end
    end
end


function M:Init()
    self._view.btn_confirm:onClick(Bind(self, self._OnClickYes)) 
    self._view.btn_close:onClick(Bind(self, self._OnClickBack)) 
    self._view.looplist:Init(Bind(self, self.UpdateItem))
    self:_InitBtns()
end


function M:_InitBtns()
    local str = "toggle%d"
    for i=1,7 do
        local name = string.format(str, i)
        local view = self._view[name]

        view:OnToggleClick(Bind(self, self._OnClickHeroType, i))
    end
end


function M:_OnClickHeroType(index)
    local type = index - 1
    local data = {}

    if type == 0 then
        data = IHeroDataMgr:GetHeros()
    else
        data = IHeroDataMgr:GetHerosByProfessinal(type) 
    end
    
    self:_FitData(data)
    self:_ShowList()
end


function M:_OnClickItem(heroId)
    local curKey = MapUtil.FindKey(self._selectHeroId,function (v) return v == heroId end)

    if self._index ~= 0 then
        self:_SelectHeroId(heroId, curKey)
    else
        self:_SelectHeroIds(heroId, curKey)
    end

    self._view.looplist:UpdateList()
end


function M:_OnClickYes()
    self._callback(self._selectHeroId, self._index)
    self:_OnClickBack()
end


function M:_OnClickBack()
    self:Close()
end




return SelectHeroUICtrl