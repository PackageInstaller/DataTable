local this = {

};

local objs = {
    imgTitle = { path = "root/Middle/Bg/TitleBox/ImgTitle", type = "Image" },
    imgContent1 = { path = "root/Middle/Bg/TitleBox/ImgContent1", type = "Image" },
    imgContent2 = { path = "root/Middle/Bg/TitleBox/ImgContent2", type = "Image" },
    imgContent3 = { path = "root/Middle/Bg/TitleBox/ImgContent3", type = "Image" },


};


this.SetData = function(index)
    local str = string.format("ui_hd_wps_zcbt%s_0", index)
    local spritObj = LuaMgr.GetSprite("YPS", str .. "1");
    this.imgTitle.sprite = spritObj
    this.imgTitle:SetNativeSize()
    SetActive(this.imgTitle.gameObject, spritObj ~= nil)
    spritObj = LuaMgr.GetSprite("YPS", str .. "2");
    this.imgContent1.sprite = spritObj
    this.imgContent1:SetNativeSize()
    SetActive(this.imgContent1.gameObject, spritObj ~= nil)
    spritObj = LuaMgr.GetSprite("YPS", str .. "3");
    this.imgContent2.sprite = spritObj
    this.imgContent2:SetNativeSize()
    SetActive(this.imgContent2.gameObject, spritObj ~= nil)
    spritObj = LuaMgr.GetSprite("YPS", str .. "4");
    this.imgContent3.sprite = spritObj
    this.imgContent3:SetNativeSize()
    SetActive(this.imgContent3.gameObject, spritObj ~= nil)
    if this.delay ~= nil then
        coroutine_runner.stop(this.delay)
        this.delay = nil
    end
    this.delay =
        coroutine_runner.start(
            function()
                coroutine_runner.wait(2)
                LuaMgr.ShowLuaPanel(UIName.YPSExploreViewModel, index);
                coroutine_runner.wait(2)
                LuaMgr.HidePanel(UIName.YPSSwitchViewModel);
            end
        )
end





local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetData(vm.behaviour.Params[0]);
    end,
    before_deactive = function(vm)
        if this.delay ~= nil then
            coroutine_runner.stop(this.delay)
            this.delay = nil
        end
    end,
    before_destroy = function(vm)

    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})