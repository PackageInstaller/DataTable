--[[
-----------------------------------------------------
@filename       : GmBigHostelItem
@Description    : GM请求
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("gm.GmBigHostelItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mGroupGrid = self:getChildTrans("mGroupGrid")
    self.mGroupBtn = self:getChildGO("mGroupBtn")
    self.mBtnAdd99 = self:getChildGO("mBtnAdd99")
    self.mBtnCopy = self:getChildGO("mBtnCopy")

    self:addOnClick(self.mBtnAdd99, self.onAdd99)
    self:addOnClick(self.mBtnCopy, self.onCopy)
end

function setData(self, param)
    super.setData(self, param)
    self.mGroupBtn:SetActive(false)
    self.mBtnCopy:SetActive(false)

    if (self.data.item_id) then
        self.mPropsGrid = PropsGrid:create(self.mGroupGrid, {self.data.item_id, 1})

        self.mPropsGrid:setCallBack(self, self.onClickGridHandler)
        self.mPropsGrid:setIsShowName(true)
    end
end

function onClickGridHandler(self)
    self.mGroupBtn:SetActive(true)
end

--
function onAdd99(self)
    bigHostel.BigHostelManager:setHostelData({
        model_id = self.data.model_id,
        heroTid = self.data.hero_tid,
        main_type = BigHostelConst.SceneUI_Type.INTERACTIVE,
    })
    map.MapLoader:setIsForceLoad(true)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BIG_HOSTEL)
end
--设为主界面
function onCopy(self)
    bigHostel.BigHostelManager:setHostelData({
        model_id = self.data.model_id,
        heroTid = self.data.hero_tid,
        main_type = BigHostelConst.SceneUI_Type.MIANUI,
    })
    map.MapLoader:setIsForceLoad(true)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.BIG_HOSTEL)

    bigHostel.BigHostelManager:setMainUIShow({model_id = self.data.model_id, heroTid = self.data.hero_tid})
end

function deActive(self)
    super.deActive(self)
    if (self.mPropsGrid) then
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
    end

end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
