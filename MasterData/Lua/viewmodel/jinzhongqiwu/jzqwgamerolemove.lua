JZQWGameRoleMove = JZQWGameRoleMove or {}

JZQWGameRoleMove.Bind = function(this)
    this.InitMainRole = function()
        SetActive(this.maleRole.gameObject, DataMgr.Player.sex == 1)
        SetActive(this.femaleRole.gameObject, DataMgr.Player.sex ~= 1)
        this.curRoleAnim = DataMgr.Player.sex == 1 and this.maleRole or this.femaleRole
        this.roleRectTrans = DataMgr.Player.sex == 1 and this.maleRoleRectTrans or this.femaleRoleRectTrans
        this.idleAnimName = DataMgr.Player.sex == 1 and "UI_Animator_JZQW_Male_Idle" or "UI_Animator_JZQW_Female_Idle"
        this.moveAnimName = DataMgr.Player.sex == 1 and "UI_Animator_JZQW_Male_Move" or "UI_Animator_JZQW_Female_Move"
    end

    this.InitInputEvents = function()
        local onPointerDown = function(eventData)
            this.StopMoveTweens()
            this.curWaitTime = 0
            SetActive(this.leftTipBtn.gameObject, false)
            SetActive(this.rightTipBtn.gameObject, false)
            SetActive(this.activateOperateTrans.gameObject, false)
            this.SetActivateArrowVis(true)
            this.curMoveActivateObj = nil
            SetActive(this.propsOperateGroup.gameObject, false)
        end
        local onPointerUp = function(eventData)
            this.curWaitTime = 0
            local touchPos = RaycastTool.GetMousePosition()
            if this.roleRectTrans == nil or touchPos == nil then
                return
            end
            local parentTrans = this.roleRectTrans.parent
            if parentTrans == nil then
                return
            end
            local targetPos = LuaMgr.Screen2Local(Vector2(touchPos.x, touchPos.y), parentTrans)
            this.ControlRolePos(targetPos)
        end
        this.dragBehaviour.onPointerUp = onPointerUp
        this.dragBehaviour.onPointerDown = onPointerDown
    end

    this.StopMoveTweens = function()
        if this.moveTweener ~= nil then
            this.moveTweener.onComplete = nil
            this.moveTweener:Kill(false)
            this.moveTweener = nil
            this.curRoleAnim:Play(this.idleAnimName, 0, 0)
        end
        if this.scrollTweener ~= nil then
            this.scrollTweener.onComplete = nil
            this.scrollTweener:Kill(false)
            this.scrollTweener = nil
        end
    end

    this.SetRoleFaceToX = function(targetX)
        if this.roleRectTrans == nil or targetX == nil then
            return
        end
        local orginScale = this.roleOrigenScale
        local isForward = this.roleRectTrans.anchoredPosition.x < targetX
        this.roleRectTrans.localScale = Vector3(isForward == true and orginScale.x or orginScale.x * -1, orginScale.y, 1)
    end

    this.ControlRolePos = function(pos, callback)
        if this.roleRectTrans == nil or pos == nil then
            return
        end
        local getter = function()
            return this.roleRectTrans.anchoredPosition
        end
        local setter = function(pos)
            this.roleRectTrans.anchoredPosition = pos
        end
        local curPos = this.roleRectTrans.anchoredPosition
        local targetpos = Vector2(pos.x, curPos.y)
        local isForward = curPos.x < targetpos.x
        local orginScale = this.roleOrigenScale
        this.roleRectTrans.localScale = Vector3(isForward == true and orginScale.x or orginScale.x * -1, orginScale.y, 1)
        local speed = JZQWConst.RoleMoveSpeed
        local distance = Vector2.Distance(curPos, targetpos)
        local during = distance / speed
        if during <= 0 then
            this.OnRoleMoveComplete(callback)
            return
        end
        this.moveTweener = DOTWeen.To(getter, setter, targetpos, during):SetEase(Ease.Linear)
        local moveTweener = this.moveTweener
        this.moveTweener.onComplete = function()
            if this.moveTweener ~= moveTweener then
                return
            end
            this.curRoleAnim:Play(this.idleAnimName, 0, 0)
            this.moveTweener = nil
            this.OnRoleMoveComplete(callback)
        end
        this.curRoleAnim:Play(this.moveAnimName, 0, 0)
    end

    this.OnRoleMoveComplete = function(callback)
        if this.curMoveActivateObj ~= nil then
            this.SetRoleFaceToX(this.curMoveFaceTargetX)
            this.MoveScrollToTargetCenter(this.curMoveActivateObj.data:GetPos().x, callback)
        elseif callback then
            callback()
        end
    end

    this.MoveScrollToTargetCenter = function(targetX, callback)
        local content = this.dragBehaviour and this.dragBehaviour.content or nil
        local viewport = this.dragBehaviour and this.dragBehaviour.viewport or nil
        if content == nil or viewport == nil or targetX == nil then
            if callback then
                callback()
            end
            return
        end
        local maxScrollX = content.rect.width - viewport.rect.width
        if maxScrollX <= 0 then
            if callback then
                callback()
            end
            return
        end
        local halfScrollX = maxScrollX / 2
        local targetContentX = math.max(-halfScrollX, math.min(halfScrollX, -targetX))
        local curPos = content.anchoredPosition
        local distance = math.abs(targetContentX - curPos.x)
        if distance <= 0.001 then
            if callback then
                callback()
            end
            return
        end

        local getter = function()
            return content.anchoredPosition
        end
        local setter = function(pos)
            content.anchoredPosition = pos
        end
        local targetPos = Vector2(targetContentX, curPos.y)
        local during = distance / JZQWConst.ScrollMoveSpeed
        this.scrollTweener = DOTWeen.To(getter, setter, targetPos, during):SetEase(Ease.Linear)
        local scrollTweener = this.scrollTweener
        this.scrollTweener.onComplete = function()
            if this.scrollTweener ~= scrollTweener then
                return
            end
            this.scrollTweener = nil
            if callback then
                callback()
            end
        end
    end
end

return JZQWGameRoleMove