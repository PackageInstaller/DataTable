module('fightUI.FightHitView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)

    self.m_bgImg = self.m_go:GetComponent(ty.Image)
    self.m_hitTxt = self:getChildGO('HitTxt'):GetComponent(ty.Text)
    self.m_descTxt = self:getChildGO('HitDescTxt'):GetComponent(ty.Text)
    -- self.m_descTxt.text = _TT(3017)
    self.m_curHitCnt = 0
    self.m_alphaTweens = {}

    self.animation = self.m_go:GetComponent(ty.Animator)
end

function show(self)
    GameDispatcher:addEventListener(EventName.FIGHT_ADD_HIT, self._addHit, self)
end

function close(self)
    GameDispatcher:removeEventListener(EventName.FIGHT_ADD_HIT, self._addHit, self)
    self:setVisibleByScale(false)
end

function resetHit(self)
    self.m_curHitCnt = 0
end

function _addHit(self)
    self:setVisibleByScale(true)
    self.m_curHitCnt = self.m_curHitCnt + 1
    if self.m_curHitCnt > 0 then
        self.m_hitTxt.text = "$" .. self.m_curHitCnt
    end

    if self.m_curHitCnt > 1 then
        self:playAnim("HitGroup_Show")
    else
        self:playAnim("HitGroup_Enter")
    end
end

function setVisibleByScale(self, visible)
    if not visible then
        if self.mIsVisible then
            self:playAnim("HitGroup_Exit")
        end
    else
        if not self.m_go.activeSelf then
            self.m_go:SetActive(true)
        end
        super.setVisibleByScale(self, visible)
    end
    self.mIsVisible = visible
end

function playAnim(self, aniName)
    if not self.m_go.activeSelf then
        return
    end
    self.animation:Play(aniName, 0, 0)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]