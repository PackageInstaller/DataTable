





JournalItemModel = {}

JournalItemModel.__index = JournalItemModel
JournalItemModel.targetPos = Vector2(985,-46)
local objs = {
    icon = {path = "ScaleAnim/Icon",type = "RawImage"},
    button = {path = "ScaleAnim/Icon",type = "Button"},
    reward = {path = "ScaleAnim/Reward",type = "GameObject"},
    lock = {path = "ScaleAnim/Lock",type = "GameObject"},
    introText = {path = "ScaleAnim/Text",type = "Text"},
    animRoot = {path = "ScaleAnim/AnimRoot",type = "GameObject"},
    animator = {path = "ScaleAnim/AnimRoot",type = "Animator"},
    scaleAnim = {path = "ScaleAnim",type = "GameObject"},
    gotoOjb = {path = "ScaleAnim/GotoBtn",type = "GameObject"},
    gotoBtn = {path = "ScaleAnim/GotoBtn",type = "Button"},
}

function JournalItemModel.New()
    local self = {}
    setmetatable(self, JournalItemModel)
    return self
end

function JournalItemModel:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        if self.lock.activeSelf or (self.animRoot.activeSelf and not self.reward.activeSelf) then
            self:ClickLock()
            return
        end
        if not HeroParameter.JournalFileClick then return end
        HeroParameter.SaveClickState()
        local getReward = nil
        if self.reward.activeSelf then
            getReward = function() self:ClickReward() end
        end
        if self.data.data.MagazineType ~= nil then
            LuaMgr.InvokeUIEventListeners(UIEventConst.JournalArchivesClick, self.data.data.MagazineType,self.data.index,getReward)
        elseif self.data.data.FileType ~= nil then
            local localFun = nil

            if self.data.data.ContentType == 1 then
                localFun = function()
                    LuaMgr.InvokeUIEventListeners(UIEventConst.JournalArchivesClick, self.data.data.FileType,self.data.index,getReward)
                end
            elseif self.data.data.ContentType == 2 then
                localFun = function()
                    LuaMgr.ShowLuaPanel(UIName.LookOverArchivesViewModel,self.data.data.TextContent[1],getReward)
                end
            end
            if self.data.data.FileType == "101" then
                if self.reward.activeSelf then
                    self:PlayAnim(localFun)
                else
                    if localFun ~= nil then
                        localFun()
                    end
                end
            else
                localFun()
            end
        end
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
    self.gotoCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.ArchivesGotoAreaExplore, self.data.data.Unlock[2])
    end
    LuaMgr.AddClick(self.gotoBtn,self.gotoCommand)
end

function JournalItemModel:SetData(data)
    self:ResetEffect()
    self.transform.localScale = Vector3(0.7,0.7,0.7)
    self.scaleAnim.transform.localScale = Vector3.one
    self.data = data.data
    SetActive(self.reward,false)
    self:SetState()
    self.icon.texture = LuaMgr.GetTexture("Images/JournalArchives/"..self.data.data.Icon..".png")

    if self.data.data.MagazineType ~= nil then
        self.introText.text = ""
    elseif self.data.data.FileType ~= nil then
        self.introText.text = LuaMgr.GetLangText(self.data.data.FileNameLan)
    end
    self.gameObject:SetActive(true)
end

function JournalItemModel:SetState()
    local tempLock = true
    if self.data.data.Unlock[1] == "1" then
        tempLock = tonumber(self.data.data.Unlock[2]) > DataMgr.Player.level
    elseif self.data.data.Unlock[1] == "2" then
        tempLock = DataMgr.Player.completedAreaEvents[self.data.data.Unlock[2]] == nil
    elseif self.data.data.Unlock[1] == "3" then
        tempLock = self:GetNovelState()
    elseif self.data.data.Unlock[1] == "4" then

        tempLock = self:GetAreaEventState(self.data.data.Unlock[2])
    end
    if self.data.data.MagazineType ~= nil then
        SetActive(self.animRoot,false)
        SetActive(self.lock,tempLock)
    elseif self.data.data.FileType ~= nil then
        if self.data.data.FileType == "101" then
            SetActive(self.lock,false)
            SetActive(self.animRoot,tempLock or DataMgr.Player.iceGorge.archivesReward[self.data.data.ID] == nil)
        else
            SetActive(self.animRoot,false)
            SetActive(self.lock,tempLock)
        end
    end
    if (self.data.data.FileType == "101" and not tempLock) or not tempLock then
        local tempReward = false
        if self.data.data.MagazineType ~= nil then
            if type(DataMgr.Player.iceGorge.journalReward) == "function" then
                tempReward = true
            else
                tempReward = DataMgr.Player.iceGorge.journalReward[self.data.data.ID] == nil
            end
        elseif self.data.data.FileType ~= nil then
            if type(DataMgr.Player.iceGorge.archivesReward) == "function" then
                tempReward = true
            else
                tempReward = DataMgr.Player.iceGorge.archivesReward[self.data.data.ID] == nil
            end
        end
        SetActive(self.reward,tempReward)
    end
    SetActive(self.gotoOjb,self.data.data.FileType == "105" and not tempLock and not self.reward.activeSelf)
end


function JournalItemModel:GetNovelState()
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == self.data.data.Unlock[2] then
            return false
        end
    end
    return true
end

function JournalItemModel:GetAreaEventState(eventId)
    if ConfigMgr.Config.areaExplores[eventId] == nil then return true end
    local areaName = nil
    areaName = ConfigMgr.Config.areaExplores[eventId].tab
    if areaName == nil then return true end
    if DataMgr.Player.areaExplores[areaName].completedExplores[eventId] == nil then
        return true
    else
        return false
    end
end

function JournalItemModel:ClickLock()
    local tipStr,condition = "",""
    if self.data.data.Unlock[1] == "1" then
        condition = self.data.data.Unlock[2]
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2128"].NameLan)
    elseif self.data.data.Unlock[1] == "2" then
        condition = LuaMgr.GetLangText(ConfigMgr.Config.dungeonMap[self.data.data.Unlock[2]].NameLan)
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2134"].NameLan)
    elseif self.data.data.Unlock[1] == "3" then
        condition = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[self.data.data.Unlock[2]].nameLan)
        tipStr = LuaMgr.GetLangText(self.data.data.UnlockTipLan)..LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13200"].NameLan)
    elseif self.data.data.Unlock[1] == "4" then
        if ConfigMgr.Config.areaExplores[self.data.data.Unlock[2]] ~= nil then
            local areaName = ConfigMgr.Config.areaExplores[self.data.data.Unlock[2]].tab
            condition = LuaMgr.GetLangText(ConfigMgr.Config.areas[areaName].mapTitlelan)
        end
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["13205"].NameLan)
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,condition))
end
function JournalItemModel:PlayAnim(localFun)
    self.animator:Play("UI_JournalFile_JournalItem",0)
    LuaMgr.AddTimer(TimerConst.JournalAnimFil,function()
        if self.data.data.ContentType == 2 then
            if localFun ~= nil then
                localFun()
                LuaMgr.RemoveTimer(TimerConst.JournalAnimFil)
                return
            end
        end
        local startPos = self.transform.anchoredPosition
        SetActive(self.reward,false)
        self.flyAnimTween = DOTWeen.To(function() return self.transform.anchoredPosition end,
                function(vector)
                    self.transform.anchoredPosition = vector
                end, self.targetPos, 0.3):SetEase(Ease.OutCubic)
        self.bigAnimTween = DOTWeen.To(function() return Vector3.one end,
                function(vector)
                    self.scaleAnim.transform.localScale = vector
                end, Vector3(1.5,1.5,1.5), 0.3):SetEase(Ease.OutCubic)
        self.bigAnimTween.onComplete = function()
            self.smallAnimTween = DOTWeen.To(function() return Vector3(1.5,1.5,1.5) end,
                    function(vector)
                        self.scaleAnim.transform.localScale = vector
                    end, Vector3(1.42,1.42,1.42), 0.3):SetEase(Ease.OutCubic)
            self.smallAnimTween.onComplete = function()
                self.transform.anchoredPosition = startPos
                self.scaleAnim.transform.localScale = Vector3.one
                if localFun ~= nil then
                    localFun()
                end
                HeroParameter.EmptyClickState()
            end
        end
        LuaMgr.RemoveTimer(TimerConst.JournalAnimFil)
    end,1.5,-1,false)
end
function JournalItemModel:ClickReward()
    local tempData = {}
    if self.data.data.MagazineType ~= nil then
        tempData.Type = "journal"
    elseif self.data.data.FileType ~= nil then
        tempData.Type = "archives"
    end
    tempData.Key = self.data.data.ID
    ApiMgr.Request("iceGorge/get_reward",tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            self:SetState()
            local rewared = json.encode(re.result)
            LuaMgr.ShowItemRewared(rewared)
            LuaMgr.InvokeUIEventListeners(UIEventConst.UpdateLabelGiftRed)
        end
    end,nil,true)
end

function JournalItemModel:ResetEffect()
    if self.flyAnimTween ~= nil then
        self.flyAnimTween.onComplete = nil
        self.flyAnimTween:Kill()
        self.flyAnimTween = nil
    end
    if self.bigAnimTween ~= nil then
        self.bigAnimTween.onComplete = nil
        self.bigAnimTween:Kill()
        self.bigAnimTween = nil
    end
    if self.smallAnimTween ~= nil then
        self.smallAnimTween.onComplete = nil
        self.smallAnimTween:Kill()
        self.smallAnimTween = nil
    end
end

function JournalItemModel:Clear()
    self.data = nil
    self:ResetEffect()
    self.gameObject:SetActive(false)
end

function JournalItemModel:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    if (self.gotoCommand ~= nil) then
        LuaMgr.RemoveClick(self.gotoBtn, self.gotoCommand)
        self.gotoCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end