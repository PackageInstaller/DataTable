





EarningCoinItem = {}
EarningCoinItem.__index = EarningCoinItem

local objs = {
    coinBtn = {path = "TotalEarningsGroup", type = UITool.Button},
    coinNum = {path = "TotalEarningsGroup/EarningsTxt", type = UITool.Text}
}


function EarningCoinItem.New(gameObjct, clickCallback)

    local self = {}
    setmetatable(self, EarningCoinItem)
    self.clickCallback = clickCallback
    self:Init(gameObjct)
    return self
end

function EarningCoinItem:Init(gameObjct)
    UITool.Parse(gameObjct, self, objs)
    self.gameObect = gameObjct
    local callBack = function()
        if self.clickCallback then
            self.clickCallback()
        end
    end
    LuaMgr.AddClick(self.coinBtn, callBack)
end

function EarningCoinItem:SetCount(count)
    self.count = count
    self.coinNum.text = string.format("+%d", count)
end