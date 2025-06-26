--[[ 
-----------------------------------------------------
@filename       : ManualMonsterItem
@Description    : 图鉴怪物
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMonsterItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mNewTans = self:getChildGO("mNewTans")
    self.mBtnClick = self:getChildGO("mBtnClick")
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgNameBg = self:getChildGO("mImgNameBg")
    self.mIconUnlock = self:getChildGO("mIconUnlock")
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mTextUnLock = self:getChildGO("mTextUnLock"):GetComponent(ty.Text)
    self.mImgJob = self:getChildGO("mImgJob"):GetComponent(ty.AutoRefImage)
    self.mImgHead = self:getChildGO("mImgHead"):GetComponent(ty.AutoRefImage)
    self:addOnClick(self.mBtnClick, self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)
    local selectVo = self.data
    local isHasFight = manual.ManualManager:judgeIsHasFight(selectVo.id) and true or false
    self.mImgNameBg:SetActive(isHasFight)
    self.mIconUnlock:SetActive(isHasFight == false)
    self.mImgHead:SetImg(selectVo:getImgUrl(), true)
    self.mNewTans:SetActive(selectVo:getIsNew())
    self.mImgHead.material = nil
    if not isHasFight then
        self.mImgHead.material = gs.ResMgr:Load(UrlManager:getUIMaterial("tex_ui_monster.mat"))
    end
    self.mImgJob:SetImg(UrlManager:getMonsterJobSmallIconUrl(selectVo.professionType, true), false)
    local isHasFightName = selectVo.name
    self.mTextUnLock.text = _TT(70100)
    -- local isHasFightJob = manual.ManualManager:judgeIsHasFight(selectVo.id) and true or false
    -- self.mImgJob.gameObject:SetActive(isHasFightJob)
    self.mTextName.text = isHasFightName
end

function onClickHandler(self, args)
    local selectVo = self.data
    if manual.ManualManager:judgeIsHasFight(selectVo.id) then
        if selectVo:getIsNew() then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_MONSTER, id = selectVo.id })
        end
        manual.ManualManager:dispatchEvent(manual.ManualManager.OPEN_MONSTER_INFOVIEW, selectVo)
    else
        gs.Message.Show(_TT(70100))
    end
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    self:removeOnClick(self.mBtnClick, self.onClickHandler)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]