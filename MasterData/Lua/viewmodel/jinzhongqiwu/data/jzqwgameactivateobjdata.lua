








JZQWGameActivateObjData = {}
JZQWGameActivateObjData.__index = JZQWGameActivateObjData

JZQWGameActivateObjData.New = function()

    local self = {}
    setmetatable(self, JZQWGameActivateObjData)
    self:Init()
    return self
end

function JZQWGameActivateObjData:Init()
    self.IsShow = true
    self:SetStatus(JZQWConst.ActivateObjStatus.Default)
    self.OnClickActivateObj = function(param)
        LuaMgr.InvokeUIEventListeners(UIEventConst.JZQWClickActivateObj, param)
    end
end

function JZQWGameActivateObjData:SetData(data)
end

function JZQWGameActivateObjData:GetPos()
    local posX = tonumber(self.Config.Coordinate[1]) or 0
    local posY = tonumber(self.Config.Coordinate[2]) or 0
    self.Pos = Vector2(posX, posY)
    return self.Pos
end

function JZQWGameActivateObjData:GetStatusImageName()
    local status = tonumber(self.Status) or JZQWConst.ActivateObjStatus.Default
    if status <= JZQWConst.ActivateObjStatus.Unlock then
        return self.Config.Asset[1]
    elseif status > #self.Config.Asset then
        return self.Config.Asset[#self.Config.Asset]
    end
    return self.Config.Asset[status]
end



function JZQWGameActivateObjData:GetInteractType()
    return self.Config.InteractType
end



function JZQWGameActivateObjData:GetObjType()
    return self.Config.Type
end



function JZQWGameActivateObjData:SetStatus(status)
    self.Status = status
end

function JZQWGameActivateObjData:GetCurTalkContent(isCommit)
    if self.Config.Param == nil or self.Config.Param == "" then
        return nil
    end

    local talkContentID = ""
    if self.Status == JZQWConst.ActivateObjStatus.Default then
        talkContentID = self.Config.Param[1]
    elseif self.Status > #self.Config.Param then
        talkContentID = self.Config.Param[#self.Config.Asset]
    else
        if self.Config.InteractType ~= JZQWConst.InteractType.MoreTalk then
            if isCommit and self.Status == JZQWConst.ActivateObjStatus.InteractEnd1 then
                talkContentID = self.Config.Param[#self.Config.Param]
            elseif self.Status == JZQWConst.ActivateObjStatus.InteractEnd1 then
                talkContentID = self.Config.Param[self.Status + 1]
            elseif self.Status == JZQWConst.ActivateObjStatus.InteractEnd2 then
                return nil
            end
        else
            if self.Status >= JZQWConst.ActivateObjStatus.InteractEnd4 then
                return nil
            else
                if isCommit == true then
                    talkContentID = self.Config.Param[self.Status + 2]
                else
                    talkContentID = self.Config.Param[self.Status + 1]
                end
            end
        end
    end
    local talkConfig = ConfigMgr.Config.AdventureNpcTalkMap[talkContentID]
    if talkConfig == nil then
        return nil
    end
    return talkConfig.TalkDescLan, talkConfig
end

function JZQWGameActivateObjData:GetNeedCommitItem()
    if type(self.Config.NeedItem) ~= "table" then
        return nil
    end

    local needItemID = nil
    if self.Status == JZQWConst.ActivateObjStatus.Default then
        needItemID = self.Config.NeedItem[1]
    elseif self.Status > #self.Config.NeedItem then
        needItemID = self.Config.NeedItem[#self.Config.NeedItem]
    else
        needItemID = self.Config.NeedItem[self.Status + 1]
    end
    if needItemID ~= "" and needItemID ~= "0" then
        return needItemID
    end
    return nil
end

function JZQWGameActivateObjData:GetNeedCommitItems()

    local needItems = nil
    if type(self.Config.NeedItems) == "table" then
        if self.Status == JZQWConst.ActivateObjStatus.Default then
            needItems = self.Config.NeedItems[1]
        elseif self.Status > #self.Config.NeedItems then
            needItems = self.Config.NeedItems[#self.Config.NeedItems]
        else
            needItems = self.Config.NeedItems[self.Status + 1]
        end
    else
        needItems = self:GetNeedCommitItem()
    end
    if needItems == nil then
        needItems = self:GetNeedCommitItem()
    end
    if needItems == nil or needItems == "" or needItems == "0" then
        return nil
    end
    if type(needItems) == "table" then
        local result = {}
        for i = 1, #needItems do
            local itemID = needItems[i]
            if itemID ~= nil and itemID ~= "" and itemID ~= "0" then
                table.insert(result, itemID)
            end
        end
        if #result > 0 then
            return result
        end
        return nil
    end
    return {needItems}
end

function JZQWGameActivateObjData:GetRecipesID()
    if type(self.Config.RecipeId) == "table" and #self.Config.RecipeId == 1 then
        return self.Config.RecipeId[1]
    end
    local receipesID = ""

    if self.Status == JZQWConst.ActivateObjStatus.Default then
        receipesID = self.Config.RecipeId[1]
    elseif self.Status > #self.Config.RecipeId then
        receipesID = self.Config.RecipeId[#self.Config.RecipeId]
    else
        if self.Config.Type == JZQWConst.ActivateType.NPC then
            receipesID = self.Config.RecipeId[self.Status + 1]
        else
            receipesID = self.Config.RecipeId[self.Status]
        end
    end
    return receipesID
end

function JZQWGameActivateObjData:CheckValidStatus(state)
    if self.Config.InteractType == JZQWConst.InteractType.Talk then
        if state < #self.Config.Asset then
            return state
        end
        return #self.Config.Asset
    end
    return self.Status
end

function JZQWGameActivateObjData:Refresh()
    if self.Config.InteractType == JZQWConst.InteractType.Pick and self.Status == JZQWConst.ActivateObjStatus.InteractEnd1 then
        self.IsShow = false
    elseif self.Config.Type == JZQWConst.ActivateType.NPC and self.Config.InteractType == JZQWConst.InteractType.Interact and self.Status == JZQWConst.ActivateObjStatus.InteractEnd2 then
        self.IsShow = false
    end
end