local this = {

};

local ui = {}

this.InitUI = function(prefab)
	ui.tarGameObject = prefab
	ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
	local uiLink = prefab.gameObject:GetComponent("UILinkLua")
	ui.root = uiLink:Get("root")
	ui.Middle = uiLink:Get("Middle")
	ui.Left = uiLink:Get("Left")
	ui.Right = uiLink:Get("Right")
	ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button")
	ui.btnUnlockGrids = uiLink:Get("btnUnlockGrids"):GetComponent("Button")
	ui.btnGM1 = uiLink:Get("btnGM1"):GetComponent("Button")
	ui.btnGM2 = uiLink:Get("btnGM2"):GetComponent("Button")
	ui.btnGM3 = uiLink:Get("btnGM3"):GetComponent("Button")
	ui.text = uiLink:Get("text"):GetComponent("Text")
	ui.inputUnLockGridsId = uiLink:Get("inputUnLockGridsId"):GetComponent("InputField")

	this.AddRegister(uiLink)
end

this.ClearUI = function()
	ui = nil
end

this.AddRegister = function(uiLink)
    uiLink:AddClickEvent("btnUnlockGrids",function()
        local strInput=ui.inputUnLockGridsId.text
        if not IsNullOrEmpty(strInput) then
            local gridIds=NumTool.split(strInput,';');
            SeasonSLGAPI.OnAskDebugUnLockGrid(gridIds,function()
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText("SeasonSLGDebugViewModel_0"))
                ui.inputUnLockGridsId.text = ""
            end);
        end
    end)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.SeasonSLGDebugViewModel)
    end)
    uiLink:AddClickEvent("btnGM1",function()
        local maxGrid = 20
        local screenGridList = this.blockScrollView:GetScreenGridIndexList()
        local gridIds = {}
        local eventProgressMap = {}
        if SeasonSLGMapMgr.MapStateData ~= nil and SeasonSLGMapMgr.MapStateData.EventProgress ~= nil then
            eventProgressMap = SeasonSLGMapMgr.MapStateData.EventProgress
        end
        for i = 1, #screenGridList do
            local gridId = tostring(screenGridList[i])
            local cfgGrid = SeasonSLGMapMgr.gridMap[gridId]
            local progressData = eventProgressMap[gridId]
            if progressData == nil then
                progressData = eventProgressMap[screenGridList[i]]
            end
            local isFull =progressData ~= nil and progressData.Progress >= cfgGrid.GridHealth
            if not isFull and #gridIds < maxGrid then
                table.insert(gridIds, gridId)
            elseif #gridIds >= maxGrid then
                break
            end
        end
        if #gridIds > 0 then
            SeasonSLGAPI.OnAskAddGridProgress(gridIds)
        end
    end)
    uiLink:AddClickEvent("btnGM2",function()
        SeasonSLGAPI.OnAskClearMisinter()
    end)
    uiLink:AddClickEvent("btnGM3",function()
        SeasonSLGAPI.OnAskAddTechPoint()
    end)
end

local data = {}

local command =
{
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.InitUI(vm.behaviour)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function()
        this.ClearUI();
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})