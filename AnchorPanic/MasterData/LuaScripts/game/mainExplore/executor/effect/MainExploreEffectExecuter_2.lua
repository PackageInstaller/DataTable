--[[ 
-----------------------------------------------------
@filename       : MainExploreEffectExecuter_1
@Description    : 主线探索效果执行器：玩家怪物开战相关
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEffectExecuter_2", Class.impl('game/mainExplore/executor/effect/MainExploreBaseEffectExecuter'))

function __initData(self)
	super.__initData(self)
	self:clearAudio()
end

function startPlay(self, eventConfigVo, dataMsgList, delEventList, addEventList, updateEventList)
    -- 更新触发状态：设置
    mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, false)

    -- local playerTrans = mainExplore.MainExplorePlayerProxy:getThing():getTrans()
    local fightAudioData = AudioManager:playSoundEffect(UrlManager:getMainExploreSoundPath("ui_ey_fight.prefab"), nil, nil, nil, 
    function()
        local moveAudioData = AudioManager:playSoundEffect(UrlManager:getMainExploreSoundPath("ui_battle_move.prefab"), nil, nil, nil, nil)
		if(moveAudioData)then
			self.mAudioDic[moveAudioData.m_snId] = moveAudioData
		end

        local sceneCameraTrans = gs.CameraMgr:GetSceneCamera()
        if sceneCameraTrans and not gs.GoUtil.IsCompNull(sceneCameraTrans) then
            local sceneCamera = sceneCameraTrans:GetComponent(ty.PostProcessing)
            sceneCamera.PostProcessToggle = true
            sceneCamera.RadialBlurToggle = true
            sceneCamera.QualityRadialBlurToggle = true
            sceneCamera.RadialAmount = 0
            
            local delayFrame = sysParam.SysParamManager:getValue(SysParamType.MAIN_EXPLORE_FIGHT_EFFECT_TIME, 30)
            LoopManager:addFrame(1, delayFrame, self,
            function()
                delayFrame = delayFrame - 1
                if(delayFrame <= 0)then
					-- 此处不移除，等进入战斗自动移除自身
					self:runEffectCall()
                else
                    sceneCamera.RadialAmount = 1 / delayFrame
                end
            end)
        else
			-- 此处不移除，等进入战斗自动移除自身
			self:runEffectCall()
        end
    
        -- 这里屏蔽不恢复，禁止操作直至进入战斗
        -- -- 更新触发状态：恢复
        -- mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, true)
    end)

    if(fightAudioData)then
        self.mAudioDic[fightAudioData.m_snId] = fightAudioData
    end
end

function __reset(self)
	super.__reset(self)
	self:clearAudio()
end

--清理音效
function clearAudio(self)
	if(self.mAudioDic)then
		for k, v in pairs(self.mAudioDic) do
			AudioManager:stopAudioSound(v)
		end
	end
	self.mAudioDic = {}
end

return _M