--[[ 
-----------------------------------------------------
@filename       : EquipGrid2
@Description    : 新装备格子2 （简易版）
@date           : 2022-08-10 19:34:15
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("EquipGrid2", Class.impl(BaseGrid))

UIRes = UrlManager:getUIPrefabPath("commonGrid/EquipGrid2.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    -- 是否显示名字
    self.mIsShowName = nil
    -- 显示品质底图
    self.mIsShowColorBg = true
    -- 是否显示数量
    self.mIsShowCount = nil
    -- 数量文本颜色
    self.mCountTextColor = nil
    -- 是否显示tips
    self.mIsShowUseInTip = nil
    -- 拥有数量
    self.mHasCount = 0
    -- 需要数量
    self.mNeedCount = 0
    -- 是否显示"新"标识
    self.mIsShowNew = nil
end

function configUI(self)
    -- 基础
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    self.mImgColorBg = self:getChildGO("mImgColorBg"):GetComponent(ty.AutoRefImage)
    self.mImgColorLine = self:getChildGO("mImgColorLine"):GetComponent(ty.AutoRefImage)
    -- 新的标识
    self.mImgNew = self:getChildGO("mImgNew")

    -- 强化等级
    self.mTxtLvl = self:getChildGO("mTxtLvl"):GetComponent(ty.Text)

    -- 改造
    -- self.mImgIdxTap = self:getChildGO("mImgIdxTap")
    -- self.mTxtIdx = self:getChildGO("mTxtIdx"):GetComponent(ty.Text)

    -- 精炼
    self.mGroupRefine = self:getChildGO("mGroupRefine")

    self.group = self:getChildGO("group")
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)

    if self.mPropsVo then
        self.mPropsVo:removeEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
    end


    if (self.mEndTimeloopSn) then
        self:removeTimerByIndex(self.mEndTimeloopSn)
        self.mEndTimeloopSn = nil
    end
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

-- 设置数据
function setData(self, cusData, cusParent)
    self:setParentTrans(cusParent)
    self.mPropsVo = cusData

    self.mPropsVo:addEventListener(self.mPropsVo.UPDATE_EQUIP_DETAIL_DATA, self.updateData, self)
    self:updateData()
end

-- 设置 新 标识
function setIsNew(self, isShow)
    self.mIsShowNew = isShow
    self:updateIsNew()
end

-- 更新数据
function updateData(self)
    super.updateData(self)
    self:updateName()
    self:updateColorBg()
    self:updatePropsIcon()
    self:updateSlotBg()
    self:updateIsNew()
    self:updateEquipStrengthenLvl()

end

function setActive(self, isActive)
    self.group:SetActive(isActive)
end

-- 创建道具格子新方法（通过不定参数，推荐）
function createByData(self, args)
    local parent = args.parent
    local tid = args.tid
    local num = args.num
    local scale = args.scale or 1
    local isTween = args.isTween or false
    local showUseInTip = args.showUseInTip or true


    local vo = props.PropsManager:getTypePropsVoByTid(tid)
    if args.vo then
        vo = args.vo
    end
    vo.count = num

    local item = self:poolGet()
    item:setData(vo, parent)
    item:setTween(isTween)
    item:setParent(parent)
    item:setScale(scale)
    item:setIsShowUseInTip(showUseInTip)
    return item
end

-- 创建道具格子
function create(self, parent, cusData, cusScale, _, cusIsShowUseInTip)
    local vo = nil
    local item = self:poolGet()
    if (cusData.__cname ~= props.PropsVo.__cname and cusData.__cname ~= props.EquipVo.__cname and cusData.__cname ~= props.OrderVo.__cname) then
        if cusData.tid and cusData.num then
            vo = props.PropsManager:getTypePropsVoByTid(cusData.tid)
            vo.count = cusData.num
        else
            vo = props.PropsManager:getTypePropsVoByTid(cusData[1])
            vo.count = cusData[2]
        end
    else
        vo = cusData
        -- PropsVo和EquipVo兼容处理
        if ((vo.__cname == props.PropsVo.__cname and vo.type ~= PropsType.PROPS) or (vo.__cname == equip.EquipVo.__cname and vo.type ~= PropsType.EQUIP)) then
            local newVo = props.PropsManager:getTypePropsVoByTid(vo.tid)
            newVo.count = vo.count
            vo = newVo
        end
    end
    item:setData(vo, parent)
    item:setParent(parent)
    item:setScale(cusScale)
    item:setIsShowUseInTip(cusIsShowUseInTip)
    return item
end

-- 点击触发
function onClickHandler(self)
    if (self.mCallFun and self.mCallObj) then
        -- 调用外部处理
        if self.mParams then
            self.mCallFun(self.mCallObj, self.mPropsVo, unpack(self.mParams))
        else
            self.mCallFun(self.mCallObj, self.mPropsVo)
        end
    else
        -- 内部默认处理
        self:onDefaultClickHandler()
    end

    if self.isNew then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = self.mPropsVo.id })
    end
end

------------------------------------------------------------------------
-- 设置自定义道具名
function setName(self, cusName)
    self.mCustomName = cusName
    self:updateName()
end

-- 设置是否显示道具名
function setIsShowName(self, isShowName)
    self.mIsShowName = isShowName
    self:updateName()
end

-- 设置是否显示颜色背景状态
function setShowColorBgState(self, isShow)
    self.mIsShowColorBg = isShow
    self:updateColorBg()
end

-- 设置强化等级
function setShowEquipStrengthenLvl(self, isShow)
    self.mIsShowEquipStrengthenLvl = isShow
    self:updateEquipStrengthenLvl()
end

-- 设置打开的tip是否显示使用按钮
function setIsShowUseInTip(self, isShowUseInTip)
    self.mIsShowUseInTip = isShowUseInTip
end

-- 获取打开tips使用按钮
function getIsShowUseInTip(self)
    return self.mIsShowUseInTip
end


----------------------------------------------------------------------

-- 设置道具名
function updateName(self)
    if (self.mIsShowName == true) then
        self.mTxtName.gameObject:SetActive(true)
        if (self.mCustomName == nil) then
            self.mTxtName.text = self.mPropsVo:getName()
        else
            self.mTxtName.text = self.mCustomName
        end
    else
        self.mTxtName.gameObject:SetActive(false)
    end

end

-- 更新道具图标
function updatePropsIcon(self)
    self.mImgIcon:SetImg(UrlManager:getPropsIconUrl(self.mPropsVo.tid), false)
end

-- 更新背景图
function updateColorBg(self)
    if self.mIsShowColorBg then
        if self.mPropsVo.type == PropsType.EQUIP then
            self.mImgColorBg:SetImg(UrlManager:getEquipBgUrl(self.mPropsVo.color), false)
        elseif self.mPropsVo.type == PropsType.ORDER then
            self.mImgColorBg:SetImg(UrlManager:getOrderBgUrl(), false)
        else
            self.mImgColorBg:SetImg(UrlManager:getPropsBgUrl(self.mPropsVo.color), false)
        end
        self.mImgColorLine.color = gs.ColorUtil.GetColor(ColorUtil:getPropLineColor(self.mPropsVo.color))
    end
    self.mImgColorBg.gameObject:SetActive(self.mIsShowColorBg)
    self.mImgColorLine.gameObject:SetActive(self.mIsShowColorBg)
end

-- 更新 新 标识
function updateIsNew(self)
    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, self.mPropsVo.id)
    if self.mIsShowNew ~= nil then
        self.mImgNew:SetActive(self.mIsShowNew)
        return
    end
    self.mImgNew:SetActive(self.isNew)
end

-- 更新装备强化等级
function updateEquipStrengthenLvl(self)
    if self.mPropsVo.strengthenLvl and self.mPropsVo.strengthenLvl > 0 then
        self.mTxtLvl.text = "LV." .. HtmlUtil:size(self.mPropsVo.strengthenLvl, 20)
    else
        self.mTxtLvl.text = ""
    end
end

-- 更新角标,显示部位
function updateSlotBg(self)
    self.mImgColor:SetImg(UrlManager:getEquipSlot(self.mPropsVo.subType), false)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]