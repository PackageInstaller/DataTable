--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDisasterDetailItem
@Description    : 无限城灾害详细列表item
@date           : 2021-03-05 16:08:13
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('infiniteCity.InfiniteCityDisasterDetailItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)


    self.mGroup = self:getChildGO("mGroup")
    self.mTxtLvLab = self:getChildGO("mTxtLvLab"):GetComponent(ty.Text)
    self.mTxtLvLab.text = _TT(27129)--"灾害等级"

    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgShield = self:getChildGO("mImgShield")
    self.mTxtShield = self:getChildGO("mTxtShield"):GetComponent(ty.Text)
    self.mTxtShield.text = _TT(27147)--"与已选择的灾害冲突"

    self:addOnClick(self.mGroup, self.onClickHandler)
end

function setData(self, param)
    super.setData(self, param)

    self.mTxtLv.text = self.data.lvl
    self.mTxtName.text = self.data:getName()
    self.mTxtDes.text = self.data:getDes()
    self.mImgIcon:SetImg(UrlManager:getIconPath(string.format("infiniteCity/disaster/infiniteCity_disaster_%s.png", self.data.icon)), true)

    local list = infiniteCity.InfiniteCityManager.selectDisasterList
    self.isSelect = (table.indexof(list, self.data.id) ~= false)

    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_DISASTER_SELECT_UPDATE, self.updateDisasterDesList, self)

    self:updateState()
    self:updateBeMutex()
end

function onClickHandler(self)
    if self.isBeMutex then
        -- gs.Message.Show("已选同类型灾害")
        gs.Message.Show(_TT(27146))
        return
    end
    -- self.isSelect = self.isSelect == false
    infiniteCity.InfiniteCityManager:setSelectDisasterList(self.data.id)

    -- self:updateState()
end

function updateState(self)
    if self.isSelect then
        self.mImgSelect:SetActive(true)
    else
        self.mImgSelect:SetActive(false)
    end
end

function updateDisasterDesList(self, args)
    local state = args.state
    local id = args.id

    if id == self.data.id then
        self.isSelect = state == 1
        self:updateState()
    else
        self:updateBeMutex()
    end
end

-- 更新互斥状态
function updateBeMutex(self)
    self.isBeMutex = false
    if not self.isSelect then
        local list = infiniteCity.InfiniteCityManager.selectDisasterList
        for i, v in ipairs(list) do
            local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(v)
            if disasterData.type == self.data.type then
                self.isBeMutex = true
                break
            end
        end
    end
    self.mImgShield:SetActive(self.isBeMutex)
end

function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_DISASTER_SELECT_UPDATE, self.updateDisasterDesList, self)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mGroup)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
