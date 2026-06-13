local EncounterHeroItemCtrl = BaseClass("EncounterHeroItemCtrl" , require("Framework.UI.Component.CircularScrollViewItem"))
local M = EncounterHeroItemCtrl

function M:Init()
    self.onClickCallback = nil 
    self.view:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    local heroId = data.heroId 
    local isup = data.isup 
    local level = data.level
    local teamId = data.teamId
    local heroIndex = data.heroIdx
    self.view.heroItem:SetHeroId(heroId, level)
    self.view.select:SetActive(isup)
    self.view.same:SetActive(data.isSame)
    self.view.lock:SetActive(data.isLock and data.isup )
    --如果上阵，则设置颜色
    if data.isup then 
        if data.isA then 
            self.view.numBg:SetColor(39,151,255)
        else
            self.view.numBg:SetColor(120,79,255)
        end 
    end
    
    if heroIndex > 0 then 
        self.view.numberText:SetText(tostring(heroIndex))
    end
    self._data  = data 
end

function M:_OnClickItem(go)
    if self._data.isSame then 
        return 
    end
    if self.onClickCallback then 
        self._data.isup = not self._data.isup
        self.onClickCallback(self._data.heroId,self._data.isup)
    end
end

function M:OnDispose()
    self.onClickCallback = nil 
    M.super.OnDispose(self)
end

return EncounterHeroItemCtrl