local objs = {
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    buffName = {path = "root/Middle/BuffName", type = UITool.Text},
    buffDesc = {path = "root/Middle/BuffDesc", type = UITool.Text},
    buffIcon = {path = "root/Middle/Icon", type = UITool.Image}
}

local this = {}

this.before_awake = function()
end

this.before_active = function()
    this.buffName.text = this.buffData.Name
    this.buffDesc.text = this.buffData.Desc
    this.buffIcon.sprite = LuaMgr.GetSprite("BuffIcon", this.buffData.BuffIcon)
end

this.OnClickCloseButton = function()
    LuaMgr.HidePanel(UIName.SCNJBuffInfoPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseButton)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.buffData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseButton)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)