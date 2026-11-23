




local onDragBehaviour
local m_LastDragPos
local limitposx = Vector2(-10, 10)
local limitposy = Vector2(-15, 15)
local this = { vm = nil }
local data = {

}
local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            CollectorPracticeMgr.OnBack();
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        onDragBehaviour = vm.behaviour.transform:Find("root/BG"):GetComponent("OnDragBehaviour")


    end,
    before_active = function(vm)
        print("before_active")
        if (vm.behaviour.Params ~= nil) then
            this.vm.behaviour:UpdateTopBar("", CollectorPracticeMgr.OnBack)
            onDragBehaviour.onDrag = this.OnDrag
            onDragBehaviour.onPointerDown = this.PointerDown
            onDragBehaviour.onPointerUp = this.OnPointerUp
            onDragBehaviour.onEndDrag = this.OnEndDrag
        end
    end,
    before_deactive = function(vm)

    end
}

this.PointerDown = function(eventData)
    m_LastDragPos = eventData.position;
end

this.OnPointerUp = function(eventData)

end
this.OnEndDrag = function(eventData)

end
this.OnDrag = function(eventData)
    local need = Vector2(eventData.position.x - m_LastDragPos.x, eventData.position.y - m_LastDragPos.y)
    CS.Laigu.Tools.CollecterPracticeHelper.DragCamera(need, limitposx, limitposy)
    m_LastDragPos = eventData.position;
end



return vm({
    data = data,
    command = command,
    hook = hook
})