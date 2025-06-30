module('role.RoleView', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('role/Role.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    -- local gBtnClose = self:getChildGO('gBtnClose')
    -- self:addOnClick(gBtnClose, onClose)

    -- local go = AssetLoader.GetGO('guanyu.prefab')
    -- self.m_trans = go.transform
	-- gs.TransQuick:SetRotation(go.transform, 0, 250, 0)
    -- gs.TransQuick:Pos(go.transform, -5, -1.2, 0)

    -- local aniCtrl = go:GetComponent(ty.LQAnimation)
    -- local function _aniEventCall(aniName, callTime)
    --     if aniName=="atk03" then
    --         local ppp = gs.ParticleMgr:Get("a1_eft_shiwangfeidai_02.prefab")
    --         ppp:SetRemoveTime(5)
    --         -- ppp.transform.position = go.transform.forward*2
    --         -- ppp:SetParent(self.m_trans)
    --         gs.TransQuick:PosOffsetForward(ppp.transform, go.transform, 1.6)
    --     end
    -- end
    -- aniCtrl:SetEventCall(_aniEventCall)
    -- local function _alertCall(tag)
    --     print("alert call", tag)
    -- end
    -- local function _runClick()
    --     aniCtrl:PlayFade('move')
    --     -- UIFactory:alertOK0("标题", "内容=======================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================ok",_alertCall)
    -- end
    -- self.m_loadParticleSn = 0
    -- local function _idleClick()
    --     aniCtrl:PlayFade('idle')
    --     if self.m_particle==nil then
    --         local function _loadParticleCall(particleGO)
    --             self.m_loadParticleSn = 0
    --             self.m_particle = particleGO
    --             self.m_particle:SetParent(self.m_trans)
    --         end
            
    --         gs.ParticleMgr:CancelAsyc(self.m_loadParticleSn)
    --         self.m_loadParticleSn = gs.ParticleMgr:GetAsyc("a1_eft_bingdong_01.prefab", _loadParticleCall)
    --     end
    --     -- UIFactory:alertOKCancel0("标题", "内容=======================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================================ok",_alertCall)
    -- end
    -- local atknames = {'atk01', 'atk02', 'atk03'}

    -- local function _atkClick()
    --     -- local ga = aniCtrl:GetAnimation()
    --     -- ga:CrossFadeQueued('atk01', 0.3, gs.QueueMode.PlayNow)
    --     -- ga:CrossFadeQueued('atk02')
    --     -- ga:CrossFadeQueued('atk03')
    --     -- ga:CrossFadeQueued('idle')
    --     aniCtrl:PlayFade("atk01")
    --     -- local idx = math.random( 1, #atknames )
    --     -- aniCtrl:PlayFade(atknames[idx])
        
    -- end
    -- self:addOnClick(self:getChildGO('MOVE'), _runClick)
    -- self:addOnClick(self:getChildGO('IDLE'), _idleClick)
    -- self:addOnClick(self:getChildGO('ATK'), _atkClick)

    -- local slider = self:getChildGO('Slider'):GetComponent(ty.Slider)
    -- slider.value = 250 / 360
    -- local skinned = go:GetComponentInChildren(ty.SkinnedMeshRenderer)
    -- local skinnedMat = skinned.material
    -- local tintColorProperty = gs.Shader.PropertyToID('_TintColor')
    -- local function _sliderChangeCall()
    --     gs.TransQuick:SetRotation(go.transform, 0, 60 + 240 * slider.value, 0)
    --     aniCtrl:SetSpeed(slider.value + 0.5)
    --     local val = slider.value
    --     skinnedMat:SetColor(tintColorProperty, gs.Color(1, val * 0.8, val, 1))
    --     -- skinnedMat.color = gs.Color(val, val, val, 256)

    --     -- 测试变速缓动下
    --     -- gs.FightTweenMgr.TimeScale = slider.value * 10
    --     -- FightTweenMgr:setTimeScale(slider.value * 10)
    -- end
    -- slider.onValueChanged:AddListener(_sliderChangeCall)
    -- local sn = 0
    -- local function _tmpCall()
    --     print('================= LoopManager call')
    --     LoopManager:removeTimerByIndex(sn)
    --     StandOut3DHandler:standOutOff(go)
    -- end
    -- print('==================================')
    -- sn = LoopManager:addTimer(5, 0, self, _tmpCall)

    -- StandOut3DHandler:standOut(go, 15, 0)

    -- 测试变速缓动下
    -- local tweener = TweenFactory:move2LPosX(self.m_trans, 5, 100, nil, nil)
    -- gs.FightTweenMgr:AddTweener(tweener, 2)
    -- FightTweenMgr:AddTweener(tweener, 2)
end

function active(self)
end

function deActive(self)
end

function onClose(self)
    gs.ParticleMgr:CancelAsyc(self.m_loadParticleSn)
    self.m_loadParticleSn = 0
    if self.m_particle then
        self.m_particle:Destroy()
    end
    self:close()
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
