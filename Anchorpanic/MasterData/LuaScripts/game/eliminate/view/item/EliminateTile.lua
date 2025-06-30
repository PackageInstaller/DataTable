--[[ 
-----------------------------------------------------
@filename       : EliminateTile
@Description    : 消消乐网格方格
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateTile", Class.impl())

function onRecover(self)
    self:removeEvents()
    gs.GameObject.Destroy(self.mThingGo)
    self:initData()
end

function initData(self)
    self.mThingGo = nil
    self.mThingTrans = nil
    self.mChildGos = nil
    self.mChildTrans = nil

    self.mTileVo = nil
    self.mImgIcon = nil
end

function create(self, tileVo, templateGo, parentTrans)
    self.mTileVo = tileVo
    self:configUI(templateGo, parentTrans)
    self:addEvents()
    self:updateView()
end

function configUI(self, templateGo, parentTrans)
    self.mThingGo = gs.GameObject.Instantiate(templateGo)
    self.mThingTrans = self.mThingGo:GetComponent(ty.RectTransform)
    self.mThingGo:SetActive(true)
    self.mThingTrans:SetParent(parentTrans, false)
    self.mChildGos, self.mChildTrans = GoUtil.GetChildHash(self.mThingGo)
    
    self.mRectBg = self.mChildGos["mBg"]:GetComponent(ty.RectTransform)
    self.mImgBg = self.mChildGos["mBg"]:GetComponent(ty.AutoRefImage)

    self.mRectIcon = self.mChildGos["mIcon"]:GetComponent(ty.RectTransform)
    self.mImgIcon = self.mChildGos["mIcon"]:GetComponent(ty.AutoRefImage)
end

function getTileVo(self)
    return self.mTileVo
end

function addEvents(self)
    self.mTileVo:addEventListener(self.mTileVo.UPDATE_STATE, self.onUpdateStateHandler, self)
end

function removeEvents(self)
    self.mTileVo:removeEventListener(self.mTileVo.UPDATE_STATE, self.onUpdateStateHandler, self)
end

function onUpdateStateHandler(self, args)
    self:updateView()
end

function updateView(self)
    self.mThingGo.name = eliminate.GetTileIdByRowCol(self.mTileVo.rowIndex, self.mTileVo.colIndex)
    
    self.mImgBg:SetImg(self.mTileVo:getTileIcon(), false)
    gs.TransQuick:SizeDelta(self.mRectBg, eliminate.GetTileSize(), eliminate.GetTileSize())
    gs.TransQuick:LPosXY(self.mRectBg, 0, 0)

    if(self.mTileVo:getIceIcon() == nil)then
        self.mRectIcon.gameObject:SetActive(false)
    else
        self.mRectIcon.gameObject:SetActive(true)
        self.mImgIcon:SetImg(self.mTileVo:getIceIcon(), false)
        gs.TransQuick:SizeDelta(self.mRectIcon, eliminate.GetTileSize(), eliminate.GetTileSize())
        gs.TransQuick:LPosXY(self.mRectIcon, 0, 0)
    end

    gs.TransQuick:SizeDelta(self.mThingTrans, eliminate.GetTileSize(), eliminate.GetTileSize())
    local localPosX, localPosY = eliminate.GetTileLocalPos(self.mTileVo.mapRow, self.mTileVo.mapCol, self.mTileVo.rowIndex, self.mTileVo.colIndex)
    gs.TransQuick:LPosXY(self.mThingTrans, localPosX, localPosY)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
