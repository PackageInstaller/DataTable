require("ViewModel/FoodCompose/FoodComposeBookFoodItem")

local this = {
    foodSV = nil,
};

local objs = {
    foodItem = { path = "template/FoodItem", type = "GameObject" },
    foodsGO = { path = "root/Middle/Book/Foods", type = "GameObject" },
    closeBtn = { path = "root/Middle/Book/Close", type = "Button" },
};


this.SetData = function()
    this.SetFoodList();
end


this.SetFoodList = function()
    this.foodSV:Clear(false);
    local scrollData;
    local scrollDatas = {};
    local foods = FoodComposeMgr.GetComposeFoods();
    local len = #foods;
    for i = 1, len do
        scrollData = UIScrollData.GetData(this.foodItem, "FoodComposeBookFoodItem", 690, 160, foods[i]);
        table.insert(scrollDatas, scrollData);
    end
    this.foodSV:SetParams(690, 490);
    this.foodSV:SetData(scrollDatas, true);
end


this.OnClickClose = function()
	if (FoodComposeMgr.GameTime() > 0) then
		FoodComposeMgr.Play();
	end
    LuaMgr.HidePanel(UIName.FoodComposeBookViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.foodSV = UIScrollView.New(this.foodsGO);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
    end,
    before_deactive = function(vm)
        this.foodSV:Clear(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        UIScrollView.ClearItem("FoodComposeBookFoodItem");
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})