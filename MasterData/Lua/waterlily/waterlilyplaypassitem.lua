








WaterlilyPlayPassItem = {}
WaterlilyPlayPassItem.__index = WaterlilyPlayPassItem

local objs = {
    button = {path = "", type = UITool.Button},
    groupObj = {path = "Group", type = UITool.GameObject},
    flag = {path = "Group/Flag", type = UITool.GameObject},
    titleText = {path = "Group/TitleText", type = UITool.Text},
    lockFlag = {path = "Group/LockFlag", type = UITool.GameObject},
    battleFlag = {path = "Group/TitleText/BattleFlag", type = UITool.GameObject},
}

function WaterlilyPlayPassItem.New()
    local self = {}
    setmetatable(self, WaterlilyPlayPassItem)
    return self
end

function WaterlilyPlayPassItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.groupObj, false)
    self.onClickCallback = function()
        if self.data.isUnLock == false then
            local tipsContent = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319"), self.data.unlockPassName)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data and self.data.onClickCallback then
            self.data.onClickCallback(self)
        else
            LuaDebug.error("WaterlilyPlayPassItem onClickCallback is nil")
        end
    end
    LuaMgr.AddClick(self.button, self.onClickCallback)
end

function WaterlilyPlayPassItem:SetData(data)
    self.data = data.data or data
    if self.data.isUnLock == true then
        self.titleText.text = LuaMgr.GetLangText(self.data.config.namelan);
    else
        self.titleText.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_25508");
    end
    SetActive(self.groupObj, true)
    SetActive(self.flag, self.data.isFinish == true)
    SetActive(self.lockFlag, self.data.isUnLock == false)
    SetActive(self.battleFlag, self.data.isUnLock == true)
end

function WaterlilyPlayPassItem:Clear()
    self:ClearItems()
end

function WaterlilyPlayPassItem:ClearItems()
    SetActive(self.groupObj, true)
    self.data = nil
end

function WaterlilyPlayPassItem:Destroy()
    
end