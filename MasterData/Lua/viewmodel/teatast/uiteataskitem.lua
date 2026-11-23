
UITeaTaskItem = {}
UITeaTaskItem.__index = UITeaTaskItem

function UITeaTaskItem.New()
    local self = {}
    setmetatable(self, UITeaTaskItem)
    return self
end

function UITeaTaskItem:Destroy()
    self.Id=nil;
    self.gameObject = nil
    self.transform = nil
    self.textTitle = nil;
    self.btnGet = nil;
    self.btnGoTo = nil;
    self.goGoodsItem = nil;
end

function UITeaTaskItem:Init()
    if self.textTitle == nil then
        local uiLink = self.gameObject:GetComponent("UILink");
        self.textTitle = uiLink:Get("textTitle"):GetComponent("Text");
        self.btnGet = uiLink:Get("btnGet");
        self.btnGoTo = uiLink:Get("btnGoTo");
        self.btnIsGet = uiLink:Get("btnIsGet");
        self.goIsGet = uiLink:Get("goIsGet");
        self.goGoodsItem = uiLink:Get("goGoodsItem"):GetComponent("GoodsViewModel");
        SetActive( self.goGoodsItem.gameObject,true);
        SetActive( self.btnGet,false);
        SetActive( self.btnGoTo,false);
        SetActive( self.btnIsGet,false);
        SetActive(self.goIsGet,false);
        uiLink:AddClickEvent("btnGoTo",function()
            local id = FoundationMgr.GetCurrBuildingId();
            local building = FoundationBuildingMgr.GetBuildingById(tostring(id));
            if self.PageSkip~=nil or self.PageSkip~="" then
                if self.PageSkip=="ConnectFourViewModel" then
                    local unlockLv=ConfigMgr.Config.constants.FourInLineUnlock;
                    if building.config.Level<unlockLv then
                        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                        return
                    end

                elseif self.PageSkip=="TurnTableMainPageViewModel" then
                    local unlockLv=ConfigMgr.Config.constants.GameBoardUnlock;
                    if building.config.Level<unlockLv then
                        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                        return
                    end

                elseif self.PageSkip=="MiniGame2048ViewModel" then
                    local unlockLv=ConfigMgr.Config.constants.NumberMergeUnlock;
                    if building.config.Level<unlockLv then
                        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                        return
                    end
                elseif self.PageSkip=="TeaTastSipViewModel" then
                    TeaTastSipViewModel.ClickOptionCommand();
                    return;
                elseif self.PageSkip=="SawPuzzleSelectViewModel" then
                    local unlockLv=ConfigMgr.Config.constants.PuzzleUnlock;
                    if building.config.Level<unlockLv then
                        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7056"].NameLan),unlockLv))
                        return
                    end
                end
                LuaMgr.ShowLuaPanel(self.PageSkip)
            end
        end)

        uiLink:AddClickEvent("btnGet",function()
            if  self.fun~=nil then
                self.fun(self.Id)
            end
        end)
    end
end

function UITeaTaskItem:SetData(data)
    
    self:Init();
    SetActive(self.gameObject,true)
    self.Id=data.data.taskData.Id;
    self.PageSkip=data.data.taskData.PageSkip;
    self.Tab=data.data.taskData.Tab;
    self.fun=data.data.fun;
    local teaItemLimit1= ConfigMgr.Config.constants.TeaItemLimit1;
    local count = DataMgr.Player.teaTask.AwardItem[teaItemLimit1.id];
    count=count ~=nil and count or 0;
    local isMax=count >= teaItemLimit1.count;
    
    
    local teaTask = DataMgr.Player.teaTask.List[data.data.taskData.Id];
    local configTask=ConfigMgr.Config.TeaTaskMap[data.data.taskData.Id];
    if teaTask~=nil and configTask~=nil then
        SetActive( self.btnGoTo,false);
        local value=configTask.Condition1[#configTask.Condition1]
        if not teaTask.IsPrize then
            if teaTask.Value>=value then
                if isMax then
                    SetActive( self.btnGet,true);
                    SetActive( self.btnGoTo,false);

                    SetActive( self.goIsGet,true);
                else
                    SetActive( self.btnGet,true);
                    SetActive( self.btnGoTo,false);

                    SetActive( self.goIsGet,false);
                end
            else
                if isMax then
                    SetActive( self.btnGet,true);
                    SetActive( self.btnGoTo,false);

                    SetActive( self.goIsGet,true);
                else
                    SetActive( self.btnGet,false);
                    SetActive( self.btnGoTo,true);

                    SetActive( self.goIsGet,false);
                end
            end
        else
            SetActive( self.btnGet,false);
            SetActive( self.btnGoTo,false);

            SetActive( self.goIsGet,true);
        end
    else
        if isMax then
            SetActive( self.btnGet,false);
            SetActive( self.btnGoTo,true);

            SetActive( self.goIsGet,true);
        else
            SetActive( self.btnGet,false);
            SetActive( self.btnGoTo,true);

            SetActive( self.goIsGet,false);
        end
    end

    self.textTitle.text = LuaMgr.GetLangText(data.data.taskData.Namelan)
    if data.data.taskData.Reward~=nil and #data.data.taskData.Reward>=1 then
        self.goGoodsItem:SetData(tostring(data.data.taskData.Reward[1].id),data.data.taskData.Reward[1].count,1,0.52,true)
    end
end

function UITeaTaskItem:Clear()

end