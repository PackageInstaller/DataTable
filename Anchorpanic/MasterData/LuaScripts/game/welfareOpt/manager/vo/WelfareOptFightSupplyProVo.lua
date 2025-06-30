module("WelfareOptFightSupplyProVo",Class.impl())

function pareseFightSupplyProVo(self,cusData)
    self.itemDic1 = cusData.item_dic1
    self.itemDic2 = cusData.item_dic2

    self.des1 = cusData.des_1
    self.des2 = cusData.des_2
end

function getColorDic(self,dicId)
    local retData = {}
    if dicId == 1 then
        for id,data in pairs( self.itemDic1) do
            retData[id] = data
        end
    else
        for id,data in pairs( self.itemDic2) do
            retData[id] = data
        end
    end
    return retData
end

function getDes(self,dicId)
    if dicId == 1 then
        return self.des1
    else
        return self.des2
    end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
