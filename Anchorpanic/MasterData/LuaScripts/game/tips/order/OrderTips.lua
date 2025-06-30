-- module("tips.OrderTips", Class.impl(tips.BaseTips))

-- UIRes = UrlManager:getUIPrefabPath("tips/OrderTips.prefab")

-- BtnType = {
--     -- 穿装备
--     LOAD_EQUIP = 1,
--     -- 脱装备
--     UNLOAD_EQUIP = 2,
--     -- 培养
--     BUILD_EQUIP = 3
-- }

-- --构造函数
-- function ctor(self)
--     super.ctor(self)
--     self:setSize(1056, 558)
-- end

-- --析构函数
-- function dtor(self)
--     super.dtor(self)
-- end

-- --初始化UI
-- function configUI(self)
--     super.configUI(self)
-- end
-- function active(self, args)
--     super.active(self, args)

--     self.m_equipVo = args.propsVo
--     self.m_btnTypeList = args.typeList

--     self:__tempAction(args.clickPos)
--     self:__updateView()

--     if (self.m_equipVo) then
--         self.m_equipVo:addEventListener(props.PropsVo.UPDATE, self.__updateView, self)
--     end
-- end

-- function deActive(self)
--     super.deActive(self)

--     self.m_childTrans["Content"].anchoredPosition = gs.Vector2.zero

--     if (self.m_equipVo) then
--         self.m_equipVo:removeEventListener(props.PropsVo.UPDATE, self.__updateView, self)
--     end

--     self:__onCloseLinkViewHandler()
-- end

-- -- 初始化数据
-- function initData(self)
--     self:__recoverTxtGoDic()
--     self:__recoverBtnGoDic()

--     -- 是否显示获取途径
--     self.m_isShowLink = true
--     -- 数据vo
--     self.m_equipVo = nil
--     -- 按钮类型列表
--     self.m_btnTypeList = nil
--     -- 唯一实例
--     self.m_instance = nil
-- end

-- --[[ 
--     初始化界面的静态文本，图片字
--     每次打开界面都会重新读取，多语言切换时可以及时更新
-- ]]
-- function initViewText(self)
--     self:setBtnLabel(self.m_childGos["BtnReturn"], 4030, "返回")
--     self.m_childGos["TextSourceTitle"]:GetComponent(ty.Text).text = _TT(4040)
-- end

-- function __getGoUniqueName(self, goName)
--     return self.__cname .. "_" .. goName
-- end

-- function __getTxtGo(self, goName)
--     local uniqueName = self:__getGoUniqueName(goName)
--     local go = gs.GOPoolMgr:GetOther(uniqueName)
--     if (not go or gs.GoUtil.IsGoNull(go)) then
--         if (self.m_childGos and self.m_childGos[goName]) then
--             go = gs.GameObject.Instantiate(self.m_childGos[goName])
--         end
--     end
--     go:SetActive(true)
--     self.m_txtGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName }
--     return go
-- end

-- function __recoverTxtGoDic(self)
--     if (self.m_txtGoDic) then
--         for hashCode, data in pairs(self.m_txtGoDic) do
--             gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
--         end
--     end
--     self.m_txtGoDic = {}
-- end

-- function __getBtnGo(self, goName, type)
--     local uniqueName = self:__getGoUniqueName(goName)
--     local go = gs.GOPoolMgr:GetOther(uniqueName)
--     if (not go or gs.GoUtil.IsGoNull(go)) then
--         if (self.m_childGos and self.m_childGos[goName]) then
--             go = gs.GameObject.Instantiate(self.m_childGos[goName])
--         end
--     end
--     self.m_btnGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type }
--     return go
-- end

-- function __recoverBtnGoDic(self)
--     if (self.m_btnGoDic) then
--         for hashCode, data in pairs(self.m_btnGoDic) do
--             self:removeOnClick(data.go)
--             gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
--         end
--     end
--     self.m_btnGoDic = {}
-- end

-- function __updateView(self)
--     self.m_equipVo:removeEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
--     local totalAttrList, totalAttrDic = self.m_equipVo:getTotalAttr()
--     if (totalAttrList == nil and totalAttrDic == nil) then
--         self.m_equipVo:addEventListener(self.m_equipVo.UPDATE_EQUIP_DETAIL_DATA, self.__updateView, self)
--         return
--     end

--     self:__recoverTxtGoDic()
--     self:__recoverBtnGoDic()
--     self:__updateLeft()
--     self:__updateRight()
--     self:__updateIdxTap()
-- end

-- -- 更新有效期倒计时
-- function __updateTickTime(self)
--     local cdTime = self.m_propsVo.expiredTime - GameManager:getClientTime()
--     if (cdTime <= 0) then
--         --已过期
--         self.mTxtName.text = self.m_propsVo:getName()
--         self.m_textTime.text = _TT(4027)--"已过期"
--         if (self.m_loopSn) then
--             LoopManager:removeTimerByIndex(self.m_loopSn)
--             self.m_loopSn = nil
--         end
--     else
--         --未过期
--         -- local timeFormatStr = "      (%s)"
--         local timeStr = TimeUtil.getFormatTimeBySeconds_1(cdTime)
--         self.mTxtName.text = self.m_propsVo:getName()
--         self.m_textTime.text = timeStr
--     end
-- end

-- function __updateLeft(self)
--     self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
--     self.m_textTime = self.m_childGos["TextTime"]:GetComponent(ty.Text)
--     -- 非限时道具
--     if (not self.m_equipVo.expiredTime or self.m_equipVo.expiredTime <= 0) then
--         self.mTxtName.text = self.m_equipVo:getName()
--         self.m_textTime.text = ""
--     else
--         self:__updateTickTime()
--         self.m_loopSn = LoopManager:addTimer(1, 0, self, __updateTickTime)

--         local _recover = self.recover
--         self.recover = function()
--             _recover(self)
--             if (self.m_loopSn) then
--                 LoopManager:removeTimerByIndex(self.m_loopSn)
--                 self.m_loopSn = nil
--             end
--         end
--     end

--     local imgIcon = self.m_childGos["ImgIcon"]:GetComponent(ty.AutoRefImage)
--     imgIcon:SetImg(UrlManager:getPropsIconUrl(self.m_equipVo.tid), false)

--     local imgColor = self.m_childGos["ImgColor"]:GetComponent(ty.AutoRefImage)
--     imgColor:SetImg(UrlManager:getPropsBgUrl(self.m_equipVo.color), true)
--     -- :SetImg(UrlManager:getPropsTipColorIconUrl(self.m_equipVo.color), true)
    
--     local textCount = self.m_childGos["TextLvl"]:GetComponent(ty.Text)
--     textCount.text = self.m_equipVo.strengthenLvl and "Lv." .. self.m_equipVo.strengthenLvl or ""
--     self.m_childGos["ImgLvBg"]:SetActive(self.m_equipVo.strengthenLvl and true or false)

--     local textPos = self.m_childGos["TextPos"]:GetComponent(ty.Text)
--     textPos.text = bag.getEquipPosStr(self.m_equipVo.subType)

--     self.m_childTrans["TextDes"]:GetComponent(ty.Text).text = self.m_equipVo:getDes()

--     local function onLockHandler()
--         local isLock = self.m_equipVo.isLock == 0 and 1 or 0
--         GameDispatcher:dispatchEvent(EventName.REQ_PROPS_LOCK_CHANGE, { propsVo = self.m_equipVo, isLock = isLock })
--     end
--     local BtnLock = self.m_childGos["BtnLock"]:GetComponent(ty.AutoRefImage)
--     self:addOnClick(self.m_childGos["BtnLock"], onLockHandler)
--     local lockPath = self.m_equipVo.isLock == 1 and 'common_5013.png' or 'common_5014.png'
--     BtnLock:SetImg(UrlManager:getCommonPath(lockPath), false)

--     local _recover = self.recover
--     self.recover = function()
--         _recover(self)
--         self:removeOnClick(self.m_childGos["BtnLock"], onLockHandler)
--     end

--     local btnGet = self.m_childGos["BtnGet"]
--     -- 先屏蔽获取途径
--     local isCanGet = false
--     if (isCanGet) then
--         btnGet:SetActive(true)
--     else
--         btnGet:SetActive(false)
--     end
--     local textGet = self.m_childGos["TextGet"]:GetComponent(ty.LanText)
--     textGet.text = _TT(4035)--"来源"

--     self:addOnClick(btnGet, __onOpenLinkViewHandler)

--     -- 不按改造部位排列
--     -- 更新改造的显示图
--     -- 检测装备是否可改造
--     local canRemakeCount = equipBuild.EquipRemakeManager:getRemakeCount(self.m_equipVo.tid)
--     if (canRemakeCount > 0) then
--         self.m_childGos["GroupLeftRemake"]:SetActive(true)
--         local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()
--         local max = 0
--         local sortList = {}
--         for pos, arrtData in pairs(remakePosAttrDic) do
--             if (arrtData.value >= max) then
--                 table.insert(sortList, 1, arrtData)
--                 max = arrtData.value
--             else
--                 table.insert(sortList, arrtData)
--             end
--         end

--         for i = 1, canRemakeCount - #sortList do
--             table.insert(sortList, -1)
--         end

--         for i = 1, #sortList do
--             local color = ""
--             local imgUrl = ""
--             local attrData = sortList[i]
--             local img = self.m_childGos["ImgRemake_" .. i]:GetComponent(ty.AutoRefImage)
--             if (attrData == -1) then
--                 -- 灰
--                 color = "ffffffff"
--                 imgUrl = "common_1401.png"
--                 gs.TransQuick:SizeDelta(img.transform, 95, 3)
--                 img:GetComponent(ty.CanvasGroup).alpha = 0.2
--             else
--                 local key = attrData.key
--                 local value = attrData.value
--                 local maxValue = attrData.maxValue
--                 if (value >= maxValue) then
--                     -- 红
--                     color = "ff0000ff"
--                     imgUrl = "common_1401.png"
--                     gs.TransQuick:SizeDelta(img.transform, 95, 7)
--                     img:GetComponent(ty.CanvasGroup).alpha = 1
--                 else
--                     -- 蓝
--                     color = "00F6FFFF"
--                     imgUrl = "common_1401.png"
--                     gs.TransQuick:SizeDelta(img.transform, 95, 3)
--                     img:GetComponent(ty.CanvasGroup).alpha = 1
--                 end
--             end

--             img.color = gs.ColorUtil.GetColor(color)
--             img:SetImg(UrlManager:getCommonPath(imgUrl), false)
--         end

--         -- 按改造部位排列
--         -- for pos = 1, canRemakeCount do
--         --     local imgUrl = ""
--         --     local attrData = remakePosAttrDic[pos]
--         --     if(self.m_childGos["ImgRemake_" .. pos] and attrData)then
--         --         local key = attrData.key
--         --         local value = attrData.value
--         --         local maxValue = attrData.maxValue
--         --         if (value >= maxValue) then
--         --             -- 红
--         --             imgUrl = "common_5015.png"
--         --         else
--         --             -- 蓝
--         --             imgUrl = "common_5014.png"
--         --         end
--         --     else
--         --         -- 灰
--         --         imgUrl = "common_5013.png"
--         --     end
--         --     local img = self.m_childGos["ImgRemake_" .. pos]:GetComponent(ty.AutoRefImage)
--         --     img:SetImg(imgUrl, false)
--         -- end
--     else
--         self.m_childGos["GroupLeftRemake"]:SetActive(false)
--     end
-- end

-- function __updateRight(self)
--     self:__updateAttr()
--     self:__updateSkill()
--     -- self:__updateTuPoAttachAttr()
--     -- self:__updateNuclearAttr()
--     -- self:__updateSuit()
--     -- self:__updateSuit_2()
--     -- self:__updateSuit_4()
--     -- self:__updateRemake()
--     self:__updateBtnList()
-- end

-- -- 更新基础属性
-- function __updateAttr(self)
--     local totalAttrList, totalAttrDic = self.m_equipVo:getTotalAttr()
--     -- local nuclearAttrList, nuclearAttrDic = self.m_equipVo:getNuclearAttr()
--     -- local attachAttrList, attachAttrDic = self.m_equipVo:getTuPoAttachAttr()
--     for i = 1, #totalAttrList do
--         local attrVo = totalAttrList[i]
--         local attrTValue = 0
--         -- 总属性 = 基础属性 + 核能属性 + 突破附加属性，所以这里如果有核能属性或突破附加属性，则需要进行相减
--         -- 过滤核能属性
--         -- local nuclearAttr = nuclearAttrDic[attrVo.key]
--         -- if  nuclearAttr then
--         --     attrTValue = (attrVo.value - nuclearAttr)
--         -- else
--         --     attrTValue = attrVo.value
--         -- end
--         -- 过滤激活了的突破附加属性
--         -- local attachAttrVo = attachAttrDic[attrVo.key]
--         -- if attachAttrVo and attachAttrVo.isActive then
--         --     attrTValue = (attrVo.value - attachAttrVo.value)
--         -- else
--             attrTValue = attrVo.value
--         -- end
--         if (attrTValue > 0) then
--             local itemCloneGo = self:__getTxtGo("AttrItem")
--             itemCloneGo.transform:SetParent(self.m_childTrans["ShowAttr"], false)
--             local textAttr = itemCloneGo.transform:Find("TextAttr"):GetComponent(ty.Text)
--             if textAttr then
--                 textAttr.text = HtmlUtil:color(AttConst.getName(attrVo.key), ColorUtil.PURE_WHITE_NUM)
--             end
--             local textAttrValue = textAttr.transform:Find("TextAttrValue"):GetComponent(ty.Text)
--             if textAttrValue then
--                 textAttrValue.text = AttConst.getValueStr(attrVo.key, attrTValue)
--             end
--         end
--     end

--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowAttr"]);
-- end

-- -- 更新突破附加属性
-- function __updateTuPoAttachAttr(self)
--     self.m_childGos["TextTitleTuPoAttach"]:GetComponent(ty.Text).text = "附加属性"--"附加属性"

--     local attachAttrList, attachAttrDic = self.m_equipVo:getTuPoAttachAttr()
--     if (#attachAttrList > 0) then
--         self.m_childGos["GroupTuPoAttachAttr"]:SetActive(true)

--         for i = 1, #attachAttrList do
--             local attachAttrVo = attachAttrList[i]
--             local itemCloneGo = self:__getTxtGo("TuPoAttachAttrItem")
--             itemCloneGo.transform:SetParent(self.m_childTrans["ShowTuPoAttachAttr"], false)
--             local textAttr = itemCloneGo.transform:Find("TextTuPoAttachAttr"):GetComponent(ty.Text)
--             local textAttrTip = itemCloneGo.transform:Find("TextTuPoAttachAttrTip"):GetComponent(ty.Text)
--             local imgStateBg = itemCloneGo.transform:Find("ImgTuPoAttachStateBg"):GetComponent(ty.AutoRefImage)
--             local imgStateIcon = itemCloneGo.transform:Find("ImgTuPoAttachStateIcon"):GetComponent(ty.AutoRefImage)
--             if(attachAttrVo.isActive)then
--                 textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. HtmlUtil:color("+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "81cdffff"), ColorUtil.PURE_WHITE_NUM)
--                 textAttrTip.gameObject:SetActive(false)
--                 imgStateBg.color = gs.ColorUtil.GetColor("000000FF")
--                 imgStateBg:SetImg(UrlManager:getCommonPath("common_1004.png"), false)
--                 imgStateIcon:SetImg(UrlManager:getCommonPath("common_5082.png"), true)
--             else
--                 textAttr.text = HtmlUtil:color(AttConst.getName(attachAttrVo.key) .. "+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value), "7f868bff")
--                 textAttrTip.gameObject:SetActive(true)
--                 textAttrTip.text = string.substitute("突破{0}次解锁", attachAttrVo.breakUpRank - self.m_equipVo.tuPoRank)
--                 imgStateBg.color = gs.ColorUtil.GetColor("FFFFFF15")
--                 imgStateBg:SetImg(UrlManager:getCommonPath("common_1004.png"), false)
--                 imgStateIcon:SetImg(UrlManager:getCommonPath("common_5013.png"), true)
--             end
--         end
--     else
--         self.m_childGos["GroupTuPoAttachAttr"]:SetActive(false)
--     end

--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowTuPoAttachAttr"]);
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupTuPoAttachAttr"]);
-- end

-- -- -- 更新核能属性
-- -- function __updateNuclearAttr(self)
-- --     self.m_childGos["TextTitleNuclear"]:GetComponent(ty.Text).text = _TT(4036)--"核能属性"

-- --     local nuclearAttrList, nuclearAttrDic = self.m_equipVo:getNuclearAttr()
-- --     if (#nuclearAttrList > 0) then
-- --         self.m_childGos["GroupNuclearAttr"]:SetActive(true)

-- --         local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
-- --         for i = 1, #nuclearAttrList do
-- --             local des = equipConfigVo:getNuclearAttrDes(nuclearAttrList[i])
-- --             local txtCloneGo = self:__getTxtGo("TextNuclearAttr")
-- --             txtCloneGo.transform:SetParent(self.m_childTrans["ShowNuclear"], false)
-- --             txtCloneGo:GetComponent(ty.Text).text = des-- HtmlUtil:color(des, "bababaff")
-- --         end
-- --     else
-- --         self.m_childGos["GroupNuclearAttr"]:SetActive(false)
-- --     end

--     -- local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
--     -- if (skillEffectList and #skillEffectList > 0) then
--     --     self.m_childGos["GroupNuclearAttr"]:SetActive(true)

--     --     for i = 1, #skillEffectList do
--     --         local des = equip.EquipSkillManager:getSkillDes(self.m_equipVo, skillEffectList[i])
--     --         local txtCloneGo = self:__getTxtGo("TextNuclearAttr")
--     --         txtCloneGo.transform:SetParent(self.m_childTrans["ShowNuclear"], false)
--     --         txtCloneGo:GetComponent(ty.Text).text = des-- HtmlUtil:color(des, "bababaff")
--     --     end
--     -- else
--     --     if (#nuclearAttrList <= 0) then
--     --         self.m_childGos["GroupNuclearAttr"]:SetActive(false)
--     --     end
--     -- end

-- --     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowNuclear"]);
-- --     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupNuclearAttr"]);
-- --     -- local function _updateNuclearMenu()
-- --     --     self.m_childGos["ShowNuclear"]:SetActive(self.m_isOpenNuclear)
-- --     --     local scale = self.m_childTrans["ImgArrowNuclear"].localScale
-- --     --     scale.y = self.m_isOpenNuclear and -1 or 1
-- --     --     self.m_childTrans["ImgArrowNuclear"].localScale = scale
-- --     -- end
-- --     -- local function _onClickNuclearMenuHandler()
-- --     --     self.m_isOpenNuclear = not self.m_isOpenNuclear
-- --     --     _updateNuclearMenu()
-- --     -- end
-- --     -- self:addOnClick(self.m_childGos["MenuNuclear"], _onClickNuclearMenuHandler)
-- --     -- self.m_isOpenNuclear = false
-- --     -- _updateNuclearMenu()
-- --     -- local _recover = self.recover
-- --     -- self.recover = function()
-- --     --     _recover(self)
-- --     --     self:removeOnClick(self.m_childGos["MenuNuclear"], _onClickNuclearMenuHandler)
-- --     -- end
-- -- end

-- -- 更新技能
-- function __updateSkill(self)
--     self.m_childGos["GroupSkill"]:SetActive(false)
--     local skillEffectList, skillEffectDic = self.m_equipVo:getSkillEffect()
--     if (skillEffectList and #skillEffectList > 0) then
--         self.m_childGos["GroupSkill"]:SetActive(true)

--         for i = 1, #skillEffectList do
--             local skillVo = fight.SkillManager:getSkillRo(skillEffectList[i].skillId)
--             self.m_childGos["TextTitleSkill"]:GetComponent(ty.Text).text = skillVo:getName()
--             local des = equip.EquipSkillManager:getSkillDes(self.m_equipVo, skillEffectList[i])
--             local txtCloneGo = self:__getTxtGo("TextSkill")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSkill"], false)
--             txtCloneGo:GetComponent(ty.Text).text = des-- HtmlUtil:color(des, "bababaff")
--         end
--     end

--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSkill"]);
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSkill"]);
-- end

-- -- 更新套装属性
-- function __updateSuit(self)
--     self.m_childGos["TextTitleSuit"]:GetComponent(ty.Text).text = "套装"

--     local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
--     local suitId = equipConfigVo.suitId
--     local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
--     if (not suitConfigVo or (suitConfigVo.suitSkillId_2 <= 0 and suitConfigVo.suitSkillId_4 <= 0)) then
--         self.m_childGos["GroupSuit"]:SetActive(false)
--     else
--         self.m_childGos["GroupSuit"]:SetActive(true)

--         local count = 0
--         local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
--         local equipTidDic = suitIdDic[suitId]
--         local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
--         if not equipList then
--             local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
--             equipList = heroVo.equipList
--         end
--         if (equipList) then
--             for i = 1, #equipList do
--                 local propsVo = equipList[i]
--                 if (equipTidDic[propsVo.tid]) then
--                     count = count + 1
--                     if (count >= 4) then
--                         break
--                     end
--                 end
--             end
--         end

--         -- 2件套描述
--         if (suitConfigVo.suitSkillId_2 > 0) then
--             local colorStr
--             if (count >= 2) then
--                 colorStr = ColorUtil.BLUE_NUM
--             else
--                 colorStr = "bababaff"
--             end
--             local txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "2件套", colorStr)

--             txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
--             local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
--         end
--         -- 4件套描述
--         if (suitConfigVo.suitSkillId_4 > 0) then
--             local colorStr
--             if (count >= 4) then
--                 colorStr = ColorUtil.BLUE_NUM
--             else
--                 colorStr = "bababaff"
--             end
--             local txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "4件套", colorStr)

--             txtCloneGo = self:__getTxtGo("TextSuitDes")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
--             local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
--             txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(skillVo:getDesc(), colorStr)
--         end
--     end
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit"]);
--     -- local function _updateSuitMenu()
--     --     self.m_childGos["ShowSuit"]:SetActive(self.m_isOpenSuit)
--     --     local scale = self.m_childTrans["ImgArrowSuit"].localScale
--     --     scale.y = self.m_isOpenSuit and -1 or 1
--     --     self.m_childTrans["ImgArrowSuit"].localScale = scale
--     -- end
--     -- local function _onClickSuitMenuHandler()
--     --     self.m_isOpenSuit = not self.m_isOpenSuit
--     --     _updateSuitMenu()
--     -- end
--     -- self:addOnClick(self.m_childGos["MenuSuit"], _onClickSuitMenuHandler)
--     -- self.m_isOpenSuit = false
--     -- _updateSuitMenu()
--     -- local _recover = self.recover
--     -- self.recover = function()
--     --     _recover(self)
--     --     self:removeOnClick(self.m_childGos["MenuSuit"], _onClickSuitMenuHandler)
--     -- end
-- end

-- -- 更新2件套装属性
-- function __updateSuit_2(self)
--     self.m_childGos["TextTitleSuit_2"]:GetComponent(ty.Text).text = _TT(4037)--"2件套"

--     local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
--     local suitId = equipConfigVo.suitId
--     local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
--     if (not suitConfigVo or suitConfigVo.suitSkillId_2 <= 0) then
--         self.m_childGos["GroupSuit_2"]:SetActive(false)
--         self.m_childGos["GroupSuitTitle"]:SetActive(false)
--         self.m_childGos["TextSuitTitle"]:GetComponent(ty.Text).text = ""
--     else
--         self.m_childGos["GroupSuit_2"]:SetActive(true)
--         self.m_childGos["GroupSuitTitle"]:SetActive(true)
--         self.m_childGos["TextSuitTitle"]:GetComponent(ty.Text).text = suitConfigVo.name

--         local count = 0
--         local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
--         local equipTidDic = suitIdDic[suitId]
--         local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
--         if not equipList then
--             local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
--             if(heroVo)then
--                 equipList = heroVo.equipList
--             end
--         end
--         if (equipList) then
--             for i = 1, #equipList do
--                 local propsVo = equipList[i]
--                 if (equipTidDic[propsVo.tid]) then
--                     count = count + 1
--                     if (count >= 4) then
--                         break
--                     end
--                 end
--             end
--         end

--         -- 2件套描述
--         if (suitConfigVo.suitSkillId_2 > 0) then
--             local colorStr
--             if (count >= 2) then
--                 colorStr = "81CDFFff"
--             else
--                 colorStr = "bababaff"
--             end
--             -- local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
--             -- txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_2"], false)
--             -- -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的2件套 [触发技能id:" .. suitConfigVo.suitSkillId_2 .. "]", colorStr)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "2件套", colorStr)
--             local txtCloneGo = self:__getTxtGo("TextSuitDes_2")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_2"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_2 .. "的描述", colorStr)
--             local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_2)
--             txtCloneGo:GetComponent(ty.Text).text = skillVo:getDesc()
--             self.m_childGos["MenuSuit_2"]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor(colorStr)
--         end
--     end

--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_2"])
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSuit_2"])
--     -- local function _updateSuitMenu_2()
--     --     self.m_childGos["ShowSuit_2"]:SetActive(self.m_isOpenSuit_2)
--     --     local scale = self.m_childTrans["ImgArrowSuit_2"].localScale
--     --     scale.y = self.m_isOpenSuit_2 and -1 or 1
--     --     self.m_childTrans["ImgArrowSuit_2"].localScale = scale
--     -- end
--     -- local function _onClickSuitMenuHandler_2()
--     --     self.m_isOpenSuit_2 = not self.m_isOpenSuit_2
--     --     _updateSuitMenu_2()
--     -- end
--     -- self:addOnClick(self.m_childGos["MenuSuit_2"], _onClickSuitMenuHandler_2)
--     -- self.m_isOpenSuit_2 = false
--     -- _updateSuitMenu_2()
--     -- local _recover = self.recover
--     -- self.recover = function()
--     --     _recover(self)
--     --     self:removeOnClick(self.m_childGos["MenuSuit_2"], _onClickSuitMenuHandler_2)
--     -- end
-- end

-- -- 更新4件套装属性
-- function __updateSuit_4(self)
--     self.m_childGos["TextTitleSuit_4"]:GetComponent(ty.Text).text = _TT(4038)--"4件套"

--     local equipConfigVo = equip.EquipManager:getEquipConfigVo(self.m_equipVo.tid)
--     local suitId = equipConfigVo.suitId
--     local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
--     if (not suitConfigVo or suitConfigVo.suitSkillId_4 <= 0) then
--         self.m_childGos["GroupSuit_4"]:SetActive(false)
--     else
--         self.m_childGos["GroupSuit_4"]:SetActive(true)

--         local count = 0
--         local suitIdDic = equip.EquipManager:getEquipSuitIdDic()
--         local equipTidDic = suitIdDic[suitId]
--         local equipList = self.m_equipVo:getOtherRoleHeroEquipList()
--         if not equipList then
--             local heroVo = hero.HeroManager:getHeroVo(self.m_equipVo.heroId)
--             if(heroVo)then
--                 equipList = heroVo.equipList
--             end
--         end
--         if (equipList) then
--             for i = 1, #equipList do
--                 local propsVo = equipList[i]
--                 if (equipTidDic[propsVo.tid]) then
--                     count = count + 1
--                     if (count >= 4) then
--                         break
--                     end
--                 end
--             end
--         end

--         -- 4件套描述
--         if (suitConfigVo.suitSkillId_4 > 0) then
--             local colorStr
--             if (count >= 4) then
--                 colorStr = "81CDFFff"
--             else
--                 colorStr = "bababaff"
--             end
--             -- local txtCloneGo = self:__getTxtGo("TextSuitDes_4")
--             -- txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_4"], false)
--             -- -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("套装" .. suitId .. "的4件套 [触发技能id:" .. suitConfigVo.suitSkillId_4 .. "]", colorStr)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(suitConfigVo.name .. "4件套", colorStr)
--             local txtCloneGo = self:__getTxtGo("TextSuitDes_4")
--             txtCloneGo.transform:SetParent(self.m_childTrans["ShowSuit_4"], false)
--             -- txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color("技能id:" .. suitConfigVo.suitSkillId_4 .. "的描述", colorStr)
--             local skillVo = fight.SkillManager:getSkillRo(suitConfigVo.suitSkillId_4)
--             txtCloneGo:GetComponent(ty.Text).text = skillVo:getDesc()
--             self.m_childGos["MenuSuit_4"]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor(colorStr)
--         end
--     end

--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowSuit_4"]);
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupSuit_4"]);
--     -- local function _updateSuitMenu_4()
--     --     self.m_childGos["ShowSuit_4"]:SetActive(self.m_isOpenSuit_4)
--     --     local scale = self.m_childTrans["ImgArrowSuit_4"].localScale
--     --     scale.y = self.m_isOpenSuit_4 and -1 or 1
--     --     self.m_childTrans["ImgArrowSuit_4"].localScale = scale
--     -- end
--     -- local function _onClickSuitMenuHandler_4()
--     --     self.m_isOpenSuit_4 = not self.m_isOpenSuit_4
--     --     _updateSuitMenu_4()
--     -- end
--     -- self:addOnClick(self.m_childGos["MenuSuit_4"], _onClickSuitMenuHandler_4)
--     -- self.m_isOpenSuit_4 = false
--     -- _updateSuitMenu_4()
--     -- local _recover = self.recover
--     -- self.recover = function()
--     --     _recover(self)
--     --     self:removeOnClick(self.m_childGos["MenuSuit_4"], _onClickSuitMenuHandler_4)
--     -- end
-- end

-- -- 更新改造属性
-- function __updateRemake(self)
--     self.m_childGos["TextTitleRemake"]:GetComponent(ty.Text).text = _TT(4039)--"改造属性"

--     self.m_childGos["GroupRemake"]:SetActive(false)
--     local remakePosAttrList, remakePosAttrDic = self.m_equipVo:getRemakeAttr()
--     for pos, attrData in pairs(remakePosAttrDic) do
--         local key = attrData.key
--         local value = attrData.value
--         local maxValue = attrData.maxValue
--         local colorStr = ""
--         if (value >= maxValue) then
--             colorStr = ColorUtil.RED_NUM
--         else
--             colorStr = ColorUtil.BLUE_NUM
--         end

--         local txtCloneGo = self:__getTxtGo("TextRemakeDes")
--         txtCloneGo.transform:SetParent(self.m_childTrans["ShowRemake"], false)
--         txtCloneGo:GetComponent(ty.Text).text = HtmlUtil:color(AttConst.getName(key) .. "+" .. HtmlUtil:color(AttConst.getValueStr(key, value), colorStr) .. "(最大" .. HtmlUtil:color(AttConst.getValueStr(key, maxValue), ColorUtil.RED_NUM) .. ")", "bababaff")
--         self.m_childGos["GroupRemake"]:SetActive(true)
--     end

--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["GroupRemake"]);
--     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_childTrans["ShowRemake"]);
--     -- local function _updateRemakeMenu()
--     --     self.m_childGos["ShowRemake"]:SetActive(self.m_isOpenRemake)
--     --     local scale = self.m_childTrans["ImgArrowRemake"].localScale
--     --     scale.y = self.m_isOpenRemake and -1 or 1
--     --     self.m_childTrans["ImgArrowRemake"].localScale = scale
--     -- end
--     -- local function _onClickRemakeMenuHandler()
--     --     self.m_isOpenRemake = not self.m_isOpenRemake
--     --     _updateRemakeMenu()
--     -- end
--     -- self:addOnClick(self.m_childGos["MenuRemake"], _onClickRemakeMenuHandler)
--     -- self.m_isOpenRemake = false
--     -- _updateRemakeMenu()
--     -- local _recover = self.recover
--     -- self.recover = function()
--     --     _recover(self)
--     --     self:removeOnClick(self.m_childGos["MenuRemake"], _onClickRemakeMenuHandler)
--     -- end
-- end

-- function __updateBtnList(self)
--     if (not self.m_btnTypeList or #self.m_btnTypeList <= 0) then
--         self.m_childGos["GroupBtn"]:SetActive(false)
--     else
--         self.m_childGos["GroupBtn"]:SetActive(true)

--         for i = 1, #self.m_btnTypeList do
--             local btnGo = self:__getBtnGo("BtnControl", self.m_btnTypeList[i])
--             btnGo.transform:SetParent(self.m_childGos["GroupBtn"].transform, false)
--             btnGo:SetActive(true)
--             local rect = btnGo:GetComponent(ty.RectTransform)
--             gs.TransQuick:Scale(rect, 1, 1, 1)

--             local childGos, childTrans = GoUtil.GetChildHash(btnGo)
--             childGos["Text"]:GetComponent(ty.Text).text = self:__getBtnName(self.m_btnTypeList[i])

--             local function onClickHandler()
--                 self:__onClickBtnHandler(btnGo)
--             end
--             self:addOnClick(btnGo, onClickHandler)
--         end
--     end
-- end


-- -- 更新角标（显示部位，临时的）
-- function __updateIdxTap(self)
--     local str = PropsEquipSubTypeStr[self.m_equipVo.subType]
--     if(str)then
--         self.m_childGos["ImgIdxTap"]:SetActive(true)
--         self.m_childGos["TextIdx"]:GetComponent(ty.Text).text = str
--     else
--         self.m_childGos["ImgIdxTap"]:SetActive(false)
--     end
-- end

-- function __getBtnName(self, btnType)
--     local name = ""
--     if (btnType == tips.EquipTips.BtnType.LOAD_EQUIP) then
--         name = "穿戴"
--     elseif (btnType == tips.EquipTips.BtnType.UNLOAD_EQUIP) then
--         name = "卸下"
--     elseif (btnType == tips.EquipTips.BtnType.BUILD_EQUIP) then
--         name = "培养"
--     end
--     return name
-- end

-- -- 点击按钮
-- function __onClickBtnHandler(self, btnGo)
--     local data = self.m_btnGoDic[btnGo:GetHashCode()]
--     if (data.type == tips.EquipTips.BtnType.LOAD_EQUIP) then
--         -- 穿戴
--         hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, { equipVo = self.m_equipVo })
--         self:close()
--     elseif (data.type == tips.EquipTips.BtnType.UNLOAD_EQUIP) then
--         -- 卸下
--         GameDispatcher:dispatchEvent(EventName.REQ_HERO_DEL_EQUIP, { equipVo = self.m_equipVo })
--         self:close()
--     elseif (data.type == tips.EquipTips.BtnType.BUILD_EQUIP) then
--         -- 培养
--         GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_BUILD_PANEL, { equipVo = self.m_equipVo })
--         self:close()
--     end
-- end

-- function __onOpenLinkViewHandler(self)
--     self.m_childGos["Scroll View"]:SetActive(false)
--     self.m_childGos["GroupSource"]:SetActive(true)
--     self:addOnClick(self.m_childGos["BtnReturn"], __onCloseLinkViewHandler)
--     self:addOnClick(self.m_childGos["ImgLinkToucher"], __onCloseLinkViewHandler)
-- end

-- -- 关闭链接界面
-- function __onCloseLinkViewHandler(self, args)
--     self.m_childGos["Scroll View"]:SetActive(true)
--     self.m_childGos["GroupSource"]:SetActive(false)
--     self:removeOnClick(self.m_childGos["ImgLinkToucher"], __onCloseLinkViewHandler)
-- end

-- -- 在资源销毁前，对需要回收的资源进行回收处理
-- function recover(self)
--     super.recover(self)
--     self:initData()
-- end

-- return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
