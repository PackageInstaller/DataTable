module("role.FightSkinItem", Class.impl("lib.component.BaseItemRender"))

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function onInit(self, go)
    super.onInit(self, go)

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgCur = self:getChildGO("mImgCur"):GetComponent(ty.Image)
    self.mTxtCur = self:getChildGO("mTxtCur"):GetComponent(ty.Text)
    self.mImgDyn = self:getChildGO("mImgDyn"):GetComponent(ty.Image)
    self.mTxtDyn = self:getChildGO("mTxtDyn"):GetComponent(ty.Text)
    self.mImgSelect = self:getChildGO("mImgSelect"):GetComponent(ty.Image)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mBtnBg = self:getChildGO("mIconBg"):GetComponent(ty.Button)
    self:addOnClick(self.mBtnBg, self.onClickItem)

    self.mImgLock = self:getChildGO("mImgLock"):GetComponent(ty.Image)

    self.mIconBg = self:getChildTrans("mIconBg")
end

function onClickItem(self)
    if self.isRed then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.FIGHT_SKIN_BUBBLE, id = self.data.id})    
    end
 
    GameDispatcher:dispatchEvent(EventName.CHANGE_FIGHT_SKIN_SELECT, self.data.id)
end

function setData(self, param)
    super.setData(self, param)
    self.mTxtDyn.text = _TT(153004)
    self.data = param
    self.mTxtName.text = _TT(param.resName)

    self.mImgSelect.gameObject:SetActive(param.isSelect)
    self.mImgDyn.gameObject:SetActive(table.indexof01(param.tap, 1) > 0)
    self.mImgIcon:SetImg(UrlManager:getIconPath(param.icon), false)
    self.mImgCur.gameObject:SetActive(role.RoleManager:getServerFightSkinId() == param.id)

    self.mImgLock.gameObject:SetActive(role.RoleManager:getFightSkinIsLock(param.id))

    local unlockList = param.unlockList
    local item = unlockList[1]
    if item ~= 0 then
        local propsConfig = props.PropsManager:getPropsConfigVo(item)
        self.mTxtDes.text = propsConfig.des
    else
        self.mTxtDes.text = _TT(153002)
    end
    self.isRed = read.ReadManager:isModuleRead(ReadConst.FIGHT_SKIN_BUBBLE, param.id)
    if self.isRed then
        RedPointManager:add(self.mIconBg, nil, 308, 226)
    else
        RedPointManager:remove(self.mIconBg)
    end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
