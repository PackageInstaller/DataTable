
NovelInteractMgr={
	continueCallBack=nil;
}
local continueCallBack=nil;
local interCfg={}

local curPanelName;


local InteractionOther=function(imgName)
	LuaMgr.RemoveUIEventListener(UIEventConst.EscNovelClose,NovelInteractMgr.CloseNovelPanel)
	LuaMgr.AddUIEventListener(UIEventConst.EscNovelClose,NovelInteractMgr.CloseNovelPanel)
	curPanelName=interCfg.PanelName;
	LuaMgr.ShowLuaPanel(interCfg.PanelName,interCfg,continueCallBack,imgName)
end


local SetNickName=function()
	if DataMgr.Player.updateName == 1 then
		continueCallBack();
	else
		InteractionOther()
	end
end


NovelInteractMgr.StartInteraction=function(continue,type,imgName)
	continueCallBack=continue;
	interCfg=ConfigMgr.Config.NovelInteractionMap[tostring(type)];
	if interCfg==nil then
		continueCallBack()
		return
	end
	if type==2 then

		SetNickName()
	else
		InteractionOther(imgName);
	end
end

NovelInteractMgr.SetInteractMsg=function(index,fingerWorldPos)
	LuaMgr.ShowLuaPanel(UIName.NovelMsgFingerViewModel,interCfg,index,fingerWorldPos)
end

NovelInteractMgr.CloseInteractMsg=function()
	LuaMgr.HidePanel(UIName.NovelMsgFingerViewModel)
end


NovelInteractMgr.CloseNovelPanel=function()
	if curPanelName~=nil and curPanelName~="" then
		LuaMgr.HidePanel(curPanelName);
		if LuaMgr.IsPanelOpen("NovelMsgFingerViewModel") then
			LuaMgr.HidePanel("NovelMsgFingerViewModel");
		end
	end
end

return NovelInteractMgr