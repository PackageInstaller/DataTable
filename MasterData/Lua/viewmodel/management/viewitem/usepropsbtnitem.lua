






UsePropsBtnItem = {}
UsePropsBtnItem.__index = UsePropsBtnItem

local objs = {
    useBtn = {path = "", type = UITool.Button},
    maskObj = {path = "Mask", type = UITool.GameObject},
    coinNum = {path = "LeftUseNum", type = UITool.Text},
    downTimeText = {path = "Mask/DownTime", type = UITool.Text}
}


function UsePropsBtnItem.New(gameObjct, clickCallback)

    local self = {}
    setmetatable(self, UsePropsBtnItem)
    self.clickCallback = clickCallback
    self:Init(gameObjct)
    return self
end

function UsePropsBtnItem:Init(gameObjct)
    UITool.Parse(gameObjct, self, objs)
    local callBack = function()
        if self.isColdDown == true then
            return
        end
        if self.clickCallback then
            self.clickCallback(self)
        end
    end
    LuaMgr.AddClick(self.useBtn, callBack)
end

function UsePropsBtnItem:SetData(data)
    self:SetCount(data.maxCount - data.useCount)
    self:SetIsCold(data.status ~= ManagementConst.UseItemStatus.None)
end

function UsePropsBtnItem:SetCount(count)
    self.count = count
    local lanStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_27103")
    self.coinNum.text = string.format(lanStr, count)
end


function UsePropsBtnItem:SetIsCold(isColding)
    self.isColdDown = isColding
    SetActive(self.maskObj, isColding == true)
end

function UsePropsBtnItem:SetDownTimer(time)
    if time ~= nil then
        self.downTime = time
    else
        if self.downTime > 0 then
            self.downTime = self.downTime - 1
        end
    end
    self.downTimeText.text = tostring(self.downTime)
end