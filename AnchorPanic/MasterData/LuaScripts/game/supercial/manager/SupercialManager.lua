module("supercial.SupercialManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
end

-- 析构函数
function dtor(self)
end

function parseSupercialMsg(self,msg)
    --商品列表
    self.goodsList = msg.goods_list

    self:updateRed()
    GameDispatcher:dispatchEvent(EventName.UPDATE_SUPERCIAL_PANEL)
end

function updateRed(self)
    local prefixVersion =
    download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)

    local isRed = not StorageUtil:getBool1(prefixVersion .. "supercial")
    local maxId = self:getCurMaxId()
    isRed = isRed or self:getIdIsRed(maxId)
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_SUPECIAL, isRed, funcopen.FuncOpenConst.FUNC_ID_SUPECIAL)
end

function getIdIsRed(self,id)
    local vo = self:getSupercialDataById(id)
    if vo == nil then
        return false
    end

    if vo.price == 0 and self:getSupercialIsBuy(id) == false then
        return true
    end
    return false
end

function getSupercialIsBuy(self,id)
    if self.goodsList == nil then
        return false
    end
    
    for i = 1,#self.goodsList do
        if self.goodsList[i].id == id then
            return self.goodsList[i].is_buy == 1
        end
    end
    return false
end

function getCurMaxId(self)
    local maxId = 0
    for  i = 1,#self.goodsList do
        if self.goodsList[i].is_buy == 1 then
            maxId = self.goodsList[i].id
        end
    end

    if maxId <=0 then
        return 1
    end

    local curVo = self:getSupercialDataById(maxId)
    local maxId = 0
    if #curVo.postId == 1 then
        maxId = curVo.postId[1]
    else
        maxId = curVo.postId[#curVo.postId]
    end

    if maxId == nil then
        return #self.goodsList + 1
    end

    if maxId > #self.goodsList then
        return #self.goodsList + 1
    else
        return maxId
    end
end

function parseSupercialData(self)
    self.mSupercialList = {}
    local baseData = RefMgr:getData("super_gift_data")
    for k, v in pairs(baseData) do
        local vo = supercial.SupercialVo.new()
        vo:parseData(k,v)
        table.insert(self.mSupercialList, vo)
        -- self.mSupercialData[vo.id] = vo
    end

    table.sort(self.mSupercialList, function(a, b)
        return a.id < b.id
    end)
end

function getSupercialData(self)
    if self.mSupercialList == nil then
        self:parseSupercialData()
    end
    return self.mSupercialList
end

function getSupercialDataById(self,id)
    if self.mSupercialList == nil then
        self:parseSupercialData()
    end
    return self.mSupercialList[id]
end

return _M
