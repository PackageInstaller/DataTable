module("fight.LiveWeapon", Class.impl())

function ctor(self)
    self.m_weaponID = nil
    self.m_model = nil
    self.m_tran = nil
    self.m_ani = nil
    self.m_alwayEfts = {}
end

function setData(self, weaponID, parentTrans)
    self.m_weaponID = weaponID
    self.m_model = gs.ResMgr:LoadGO(self.m_weaponID)
    -- self.m_model = AssetLoader.GetGO(self.m_weaponID)
    if self.m_model then
        self.m_tran = self.m_model.transform
        self.m_tran:SetParent(parentTrans, false)
        self.m_ani = self.m_model:GetComponent(ty.AnimatCtrl)
        if self.m_ani then
            self.m_ani:LoadClipWithHash(fight.FightDef.ACT_GETUP)
        end
        local ro = fight.FightLoader:getAlwayEftRo(self.m_weaponID)
        if ro then
            local group = ro:getEftGroup()
            for i,v in ipairs(group) do
                local eftGo = gs.ResMgr:LoadGO(UrlManager:getAlwayEfxRolePath(v))
                if eftGo then
                    eftGo.transform:SetParent(self.m_tran, false)
                    local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
                    if charAppend then
                        charAppend.CharSet = self.m_model
                    end
                    table.insert(self.m_alwayEfts, eftGo)
                end
            end
        end
        return true
    end
    return false
end

function getTrans(self)
    return self.m_tran
end

function playAction(self, aniHash, fadeLength)
    if self.m_ani then
        self.m_ani:PlayHash(aniHash)
        -- self.m_ani:PlayFadeHash(aniHash, fadeLength)
    end
end
-- 通过触发器来播放动作
function playActionTrigger(self, triggerHash, resetTriggerHash)
    if self.m_ani then
        if(resetTriggerHash)then
            self.m_ani:ResetTriggers(resetTriggerHash)
        end
        self.m_ani:PlayTriggerCond(triggerHash)
    end
end

function setAnimationBoolVal(self, keyhash, val)
    if self.m_ani then
        self.m_ani:SetBoolCondtion(keyhash, val)
    end
end

function setAnimationTriggerVal(self, keyhash)
    if self.m_ani then
        self.m_ani:SetTriggerCondtion(keyhash)
    end
end

function setAniSpeed( self, aniSpeed )
    if self.m_ani then
        self.m_ani:SetSpeed(aniSpeed)
    end
end

function loadAllClip(self)
    if self.m_ani then
        self.m_ani:PreLoadAllBindClip()
    end
end

function reset(self)
    if self.m_model then
        gs.GameObject.Destroy(self.m_model)
        self.m_model = nil
        self.m_tran = nil
        self.m_ani = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
