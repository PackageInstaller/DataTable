--[[ 
-----------------------------------------------------
@filename       : GmPropsItem
@Description    : GM请求
@date           : 2022-2-22 20:22:07
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("gm.GmPropsItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mGroupGrid = self:getChildTrans("mGroupGrid")
    self.mGroupBtn = self:getChildGO("mGroupBtn")
    self.mBtnAdd1 = self:getChildGO("mBtnAdd1")
    self.mBtnAdd99 = self:getChildGO("mBtnAdd99")
    self.mBtnCopy = self:getChildGO("mBtnCopy")

    self:addOnClick(self.mBtnAdd1, self.onAdd1)
    self:addOnClick(self.mBtnAdd99, self.onAdd99)
    self:addOnClick(self.mBtnCopy, self.onCopy)
end

function setData(self, param)
    super.setData(self, param)
    self.mGroupBtn:SetActive(false)

    local propsVo = self.data
    if (propsVo) then
       if propsVo.type == PropsType.EQUIP and propsVo.subType ~= PropsEquipSubType.SLOT_7 then
            self.mPropsGrid = EquipGrid2:create(self.mGroupGrid, { propsVo.tid, 1 })
        elseif propsVo.type == PropsType.EQUIP and propsVo.subType == PropsEquipSubType.SLOT_7 then
            self.mPropsGrid = BraceletsGrid2:create(self.mGroupGrid, { propsVo.tid, 1 })
        else
            self.mPropsGrid = PropsGrid:create(self.mGroupGrid, { propsVo.tid, 1 })
        end

        --self.mPropsGrid = PropsGrid:create(self.mGroupGrid, { propsVo.tid, 1 })
        -- 此处屏蔽，由PropsGrid默认的触发tip动画
        self.mPropsGrid:setCallBack(self, self.onClickGridHandler)
        self.mPropsGrid:setIsShowName(true)
    end
end

function onClickGridHandler(self)
    self.mGroupBtn:SetActive(true)
end

-- 增加资产成功提示
function onAdd1(self)
    local cmd = string.format("add_item %s 1", self.data.tid)
    GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, { command = cmd })
    gs.Message.Show2("操作成功")
end
function onAdd99(self)
    local cmd = string.format("add_item %s 99", self.data.tid)
    GameDispatcher:dispatchEvent(EventName.REQ_GM_RUN, { command = cmd })
    gs.Message.Show2("操作成功")
end
function onCopy(self)
    local cmd = string.format("add_item %s 1", self.data.tid)
    gs.SdkManager:Copy(cmd)
    gs.Message.Show("复制命令成功")
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
