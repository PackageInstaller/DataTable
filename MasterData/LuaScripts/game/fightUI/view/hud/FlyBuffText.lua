module("fightUI.FlyBuffText", Class.impl(fightUI.HUDItem))

function ctor(self)
    super.ctor(self)
    self.m_prefabName = UrlManager:getUIPrefabPath("fight/FlyBuffText.prefab")
    -- self.m_prefabName = "FlyHudText.prefab"
end

-- 初始化数据
function initData(self, rootGo)
    super.initData(self, rootGo)
    -- self.m_text = self.m_go:GetComponent(ty.Text)
    -- self.m_ani = self.m_go:GetComponent(ty.Animation)
    local hudGo = self:getChildGO("mImgBg")
    self.hudGoT = hudGo.transform
    self.m_ani = hudGo:GetComponent(ty.Animation)
    self.m_text = self:getChildGO("mTxtEffect"):GetComponent(ty.Text)
end

function setVal(self, val)
    self.m_text.text = val
end
function preloadAnim(self, aniPath)
    if self.m_ani then
        gs.DynamicAnimation:PreloadAnimation(self.m_ani, aniPath)
    end
end

function playAnim(self, aniPath, finishCall, liveId)
    if self.m_ani then
        local callBack = function()
			finishCall(liveId)
        end
        local length = gs.DynamicAnimation:PlayAnimation04(self.m_ani, aniPath)
        if length > 0 then
            self.m_timeoutIndex = LoopManager:setTimeout(length, self, callBack)
        else
            self.m_timeoutIndex = LoopManager:setTimeout(1, self, callBack)
        end
    end
end

function addPosY(self, offset)
    -- local lp = self.m_rTrans.localPosition
    -- lp.y=lp.y+offset
    -- self.m_rTrans.localPosition = lp
    gs.TransQuick:LPosOffsetY(self.m_rTrans, offset)
end


function onRecover(self)
    super.onRecover(self)
    gs.TransQuick:LPosZero(self.hudGoT)
    if self.m_timeoutIndex ~= nil then
        LoopManager:clearTimeout(self.m_timeoutIndex)
        self.m_timeoutIndex = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]