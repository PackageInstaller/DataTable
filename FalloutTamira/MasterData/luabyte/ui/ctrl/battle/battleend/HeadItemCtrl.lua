local HeadItemCtrl = BaseClass( 'HeadItemCtrl'  )
local M = HeadItemCtrl 



function M:SetActive(isShow)
    self._view:SetActive(isShow)
end


function M:SetHeroId(heroId)
    self._view.PlayerHead:SetHeroId(heroId)
end


function M:__init(view)
    self._view = view
end


function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end



return HeadItemCtrl
