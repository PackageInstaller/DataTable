
Block_MisinterItem = {};

Block_MisinterItem.__index = Block_MisinterItem;
local objs = {
    uiSpineCharacter = { path = "root/spine", type = "UISpineCharacter" },
    spineRender={ path = "root/spine", type = "RawImage" },
    txtGuild={ path = "root/_BG/guild", type = "Text" },
    txtName={ path = "root/_BG/name", type = "Text" },
    canvasGroup={ path = "root", type = "CanvasGroup" },
    progressImg = {path = "root/Progress/ProgressImg", type = UITool.Image},
    progressTxt = {path = "root/Progress/ProgressTxt", type = UITool.Text}

};

function Block_MisinterItem.New(parent)
    local self = {};
    setmetatable(self, Block_MisinterItem);
    self.parent=parent;
    self.prefabPath = "Assets/_BundleResources/UI/SeasonSLG/MisinterItem.prefab"
    self.gameObject = LuaMgr.GetPrefab(self.prefabPath)
    self.transform=self.gameObject.transform;
    self.transform:SetParent(parent,false);
    self.transform.localScale=Vector3.one;
    self:Init();
    return self;
end

function Block_MisinterItem:Init()
    UITool.Parse(self.gameObject, self, objs);
end


function Block_MisinterItem:SetData(data)
    self.data=data;
    local dataTimeEvent=self.data.timedEventProgress;

    local cfgWorldAttack=ConfigMgr.Config.SeasonalGridWorldAttackMap[self.data.functionId]
            or ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(self.data.functionId)];
    if dataTimeEvent==nil or cfgWorldAttack==nil then
        return
    end

    local expireTime=self.data.timedEventProgress.ClientExpireTime;
    if type(expireTime)~="number" then
        SetActive(self.gameObject,false);
        return;
    end
    local remainTime=expireTime-LuaMgr.Timestamp();
    if remainTime<0 then
        SetActive(self.gameObject,false);
        return;
    end
    self.gameObject.name = self.data.functionId
    self.cfgWorldAttack = cfgWorldAttack
    local misinterId=cfgWorldAttack.SeasonalMonsterModel
    SetActive(self.uiSpineCharacter.gameObject,true);
    local renderTex=SeasonSLGMapMgr.GetRenderTexBySpinePool(misinterId.."001");
    if renderTex==nil then
        renderTex=self.uiSpineCharacter:SetBattle2(misinterId,misinterId.."001","-1",0);
        if renderTex~=nil then
            self.uiSpineCharacter:Play("idle", true, nil)
            SeasonSLGMapMgr.AddRenderTexSpinePool(misinterId,renderTex,self.uiSpineCharacter);
        end
    else
        self.spineRender.texture=renderTex.texture;
    end
    local title = cfgWorldAttack.Name
    if cfgWorldAttack.NameLan~=nil then
        title = LuaMgr.GetLangText(cfgWorldAttack.NameLan)
    end
    if cfgWorldAttack.EventLevel~=nil and title~="" then
        if cfgWorldAttack.NameChange == 1 then
            self.txtGuild.text=string.format("<color=#DE0F1E>%s</color>", title)
        else
            self.txtGuild.text=string.format("<color=#CFA4FE>%s</color>", title)
        end
    end
end

function Block_MisinterItem:RefreshRemainTime()
    if self.data==nil or self.data.timedEventProgress==nil then
        return
    end
    local expireTime=self.data.timedEventProgress.ClientExpireTime;
    if type(expireTime)~="number" then
        self.txtName.text=""
        LuaDebug.error("Block_MisinterItem:RefreshRemainTime 结束")
        return
    end
    local remainTime=expireTime-LuaMgr.Timestamp();
    if remainTime<0 then
        remainTime=0
        SetActive(self.gameObject,false);
        return;
    end
    SetActive(self.gameObject,true);
    local d,h,m=GetTimeHMS(remainTime)
    self.txtName.text=string.format(LuaMgr.GetLangText("Block_MisinterItem_0"),d,h,m);

    if self.cfgWorldAttack == nil then
        local cfgWorldAttack=ConfigMgr.Config.SeasonalGridWorldAttackMap[self.data.functionId];
        if cfgWorldAttack==nil then
            cfgWorldAttack=ConfigMgr.Config.SeasonalGridWorldAttackMap[tostring(self.data.functionId)];
        end
        self.cfgWorldAttack = cfgWorldAttack
    end
    if self.cfgWorldAttack ~= nil then
        local maxValue = self.cfgWorldAttack.SeasonalMonsterHP
        local curValue = self.data.timedEventProgress.Progress
        local perValue = math.min(1, curValue/maxValue)
        self.progressTxt.text = string.format("%0.1f%%", ((1 - perValue)) * 100)
        self.progressImg.fillAmount = (1 - perValue)
    end
end









function Block_MisinterItem:Clear()
    self.data=nil;
    self.uiSpineCharacter:Clear();
    SetActive(self.uiSpineCharacter.gameObject,false);
end

function Block_MisinterItem:Destroy()

    LuaMgr.DestroyImmediateGO(self.gameObject);
    self.gameObject = nil;
end