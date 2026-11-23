







WaterlilyPlayMovieItem = {}
WaterlilyPlayMovieItem.__index = WaterlilyPlayMovieItem

local objs = {
    button = {path = "", type = UITool.Button},
    titleText = {path = "TitleText", type = UITool.Text},
    replayImg = {path = "ReplayImg", type = UITool.Image},
    lockFlag = {path = "LockFlag", type = UITool.GameObject},
    bgImageObj = {path = "BGImage", type = UITool.GameObject}
}

function WaterlilyPlayMovieItem.New(prefab)
    local self = {}
    setmetatable(self, WaterlilyPlayMovieItem)
    self.gameObject = prefab
    UITool.Parse(self.gameObject, self, objs)
    local func = function()
        if self.data.isUnLock == false then
            local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_12000")
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data and self.data.onClickCallback then
            self.data.onClickCallback(self)
        else
            LuaDebug.error("WaterlilyPlayMovieItem onClickCallback is nil")
        end
    end
    LuaMgr.AddClick(self.button, func)
    return self
end

function WaterlilyPlayMovieItem:SetData(data)
    self.data = data
    self.titleText.text = LuaMgr.GetLangText(data.config.namelan);
    SetActive(self.replayImg.gameObject, data.isFinish == true)
    SetActive(self.lockFlag, data.isUnLock == false)
    SetActive(self.bgImageObj, data.isUnLock == true)
end