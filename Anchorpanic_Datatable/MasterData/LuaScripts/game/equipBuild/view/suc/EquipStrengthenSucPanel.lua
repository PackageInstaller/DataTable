module("equipBuild.EquipStrengthenSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("braceletBuild/success/BraceletStrengthenSucPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
    self:setTxtTitle('')
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
end

function configUI(self)
    super.configUI(self)
    self.ItemAttr = self:getChildGO("ItemAttr")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurLvl = self:getChildGO("TextCurLvl"):GetComponent(ty.Text)
    self.mTxtNextLvl = self:getChildGO("TextNextLvl"):GetComponent(ty.Text)
    self.mScrollBreakUpAttr = self:getChildTrans("AttrContent")

    self.mAni = self.UIObject:GetComponent(ty.Animator)
end

-- 设置全屏透明遮罩
function setMask(self)
    super.setMask(self)

    self:setGuideTrans("guide_BraceletStrengthenSucPanel_CloseBtn", self.mask.transform)
end

function onClickClose(self)
    self.mAni:SetTrigger("exit")

    local time = AnimatorUtil.getAnimatorClipTime(self.mAni, "BraceletStrengthenSucPanel_Exit")
    self:setTimeout(time,function ()
        super.onClickClose(self)
    end)
end

function active(self, args)
    self.mTxtTitle.text = args.isBreakUp and "强化等级突破" or "强化等级提升"
    self:setData(args.oldEquipVo, args.curEquipVo, args.isBreakUp)
end

function deActive(self)
    self:removeAllItem()
end

function initViewText(self)
end

function addAllUIEvent(self)
end

function removeAllItem(self)
    if (#self.mItemList > 0) then
        for _, item in pairs(self.mItemList) do
            item:poolRecover()
            item = nil
        end
        self.mItemList = {}
    end
end

function setData(self, oldEquipVo, curEquipVo, isBreakUp)
    self:removeAllItem()
    self.mTxtCurLvl.text = isBreakUp and oldEquipVo.tuPoRank or oldEquipVo.strengthenLvl
    self.mTxtNextLvl.text = isBreakUp and curEquipVo.tuPoRank or curEquipVo.strengthenLvl
    local oldAttrList, oldAttrDic = oldEquipVo:getMainAttr()
    local curAttrList, curAttrDic = curEquipVo:getMainAttr()
    for i = 1, #oldAttrList do
        local oldKeyValueVo = oldAttrList[i]
        if oldKeyValueVo.value ~= curAttrDic[oldKeyValueVo.key] then
            local oldKeyValueVo = oldAttrList[i]
            local item = SimpleInsItem:create(self.ItemAttr, self.mScrollBreakUpAttr, "EquipStrengthenSucPanelItemAttr")
            item:getChildGO("TextAttrTitile"):GetComponent(ty.Text).text = AttConst.getName(oldKeyValueVo.key)
            item:getChildGO("TextCurAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(oldKeyValueVo.key, oldKeyValueVo.value)
            item:getChildGO("TextNextAttr"):GetComponent(ty.Text).text = AttConst.getValueStr(oldKeyValueVo.key, curAttrDic[oldKeyValueVo.key])
            item:getChildGO("mImgChange"):SetActive(true)
        end
    end
end

function close(self)
    super.close(self)
    
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]