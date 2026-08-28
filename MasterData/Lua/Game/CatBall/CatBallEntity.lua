
---@class CatBallEntity
local CatBallEntity = Class('CatBallEntity')


function CatBallEntity:__init()
    ---@type CatEggDojo
    self.dojo = nil
    ---@type CatBallVo
    self.vo = nil
    ---@type boolean
    self.isFragment = false
    ---@type boolean
    self.isCanMerge = false
    self.isNew = false
    self.isCatBallEntity = true
end


function CatBallEntity:__delete()

end


---Fill
---填充数据
---@param cardEggDojo CatEggDojo
function CatBallEntity:Fill(cardEggDojo)
    self.dojo = cardEggDojo
    ---@type CatBallUtils
    local CatBallUtils  = import("Game.CatBall.CatBallUtils")
    --- 对应猫球id
    self.goodsId = self.dojo.catId
    ---@type CatBallVo
    self.vo  = CatBallUtils.GetCatBallVo(self.dojo.catId)
end


---FillFragment
---填充碎片数据
---@param goodsId number
---@param num number
function CatBallEntity:FillFragment(goodsId, num, goodsVo)
    ---@type CatBallUtils
    local CatBallUtils  = import("Game.CatBall.CatBallUtils")
    ---@type CatBallGoodsVo
    goodsVo = goodsVo or GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
    ---@type CatBallVo
    self.vo  = CatBallUtils.GetCatBallVo(goodsVo.cardId)
    --- 对应猫球id
    self.goodsId = self.vo.roleId
    
    self.goodsVo = goodsVo
    self.needNum = goodsVo.needNum
    self.isCanMerge = num >= self.needNum
    self.fragmentNum = num
    self.isFragment = true
end

function CatBallEntity:UpdateFragmentNum(num)
    self.fragmentNum = self.fragmentNum + num
    self.isCanMerge = self.fragmentNum >= self.needNum
end

function CatBallEntity:CompositeFragment(dojo)
    self.dojo = dojo
    self.isFragment = false
    self.isCanMerge = false
end

return CatBallEntity
