--[[ 
-----------------------------------------------------
@filename       : RoleLevelUpView
@Description    : 指挥官等级提升
@date           : 2020-12-22 19:44:17
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.RoleLevelUpView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleLevelUpView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtExp = self:getChildGO("mTxtExp"):GetComponent(ty.Text)
    self.mTxtLvNum = self:getChildGO("mTxtLvNum"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtLvNum2 = self:getChildGO("mTxtLvNum2"):GetComponent(ty.Text)
    self.mTxtLvlPre = self:getChildGO("mTxtLvlPre"):GetComponent(ty.Text)
    self.mTxtLvlCur = self:getChildGO("mTxtLvlCur"):GetComponent(ty.Text)
    self.mTxtLvNum_1 = self:getChildGO("mTxtLvNum_1"):GetComponent(ty.Text)
    self.mTxtLvNum_2 = self:getChildGO("mTxtLvNum_2"):GetComponent(ty.Text)
    self.mImgBlackBg = self:getChildGO("mImgBlackBg"):GetComponent(ty.Image)
    self.mTxtMaxStamina = self:getChildGO("mTxtMaxStamina"):GetComponent(ty.Text)
    self.mTxtOldStamina = self:getChildGO("mTxtOldStamina"):GetComponent(ty.Text)
    self.mTxtNewStamina = self:getChildGO("mTxtNewStamina"):GetComponent(ty.Text)
    self.mTxtAddStamina = self:getChildGO("mTxtAddStamina"):GetComponent(ty.Text)
    self.mTxtNumStamina = self:getChildGO("mTxtNumStamina"):GetComponent(ty.Text)
    self.mProgressBar = self:getChildGO("mProgressBar"):GetComponent(ty.ProgressBar)
    self.mProgressBar:InitData(0)
    --self.mImgAct = self:getChildTrans("mImgAct")
end

--激活
function active(self, args)
    super.active(self, args)
    self.oldLv = args.oldLv
    self:updateView()
    self.mImgBlackBg.raycastTarget = true
    --self:doEnterAction()
    self:addTimer(1.02, 1, function()
        self.mImgBlackBg.raycastTarget = false
    end)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MAXEXP, self.onPlayerExpChangeHandler, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.mProgressBar:SetValue(0, 0, false)

    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MAXEXP, self.onPlayerExpChangeHandler, self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtLv.text = "Lv."
    self.mTxtTitle.text = _TT(277)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_level_up.prefab")
end

function onPlayerExpChangeHandler(self)
    self:updateExp()
end

function updateView(self)
    local roleVo = role.RoleManager:getRoleVo()
    self.mTxtLvNum.text = self.oldLv--roleVo:getPlayerLvl()
    self.mTxtLvNum2.text = roleVo:getPlayerLvl()--roleVo:getPlayerLvl()
    --self.mTxtLvNum2.gameObject:SetActive(self.oldLv >= 10)
    --self.mTxtLvNum.gameObject:SetActive(self.oldLv < 10)
    --self.mTxtLvNum_1.text = self.oldLv
    --self.mTxtLvNum_2.text = self.oldLv
    --self:setTimeout(0.3, function()
    --    self.mTxtLvNum2.gameObject:SetActive(roleVo:getPlayerLvl() >= 10)
    --    self.mTxtLvNum.gameObject:SetActive(roleVo:getPlayerLvl() < 10)
    --    self.mTxtLvNum.text = roleVo:getPlayerLvl()
    --    self.mTxtLvNum_1.text = roleVo:getPlayerLvl()
    --    self.mTxtLvNum_2.text = roleVo:getPlayerLvl()
    --end)

    self.mTxtLvlPre.text = string.format("%02d", self.oldLv)
    self.mTxtLvlCur.text = string.format("%02d", roleVo:getPlayerLvl())

    -- self:updateExp() --先不走这段 防止策划多变

    local oldLvlVo = role.RoleManager:getLvlUpVoByLvl(self.oldLv)
    local roleLvlUpVo = role.RoleManager:getCurLvlVo()

    local addStamina = 0
    for lvl = self.oldLv, roleVo:getPlayerLvl() - 1 do
        local lvlVo = role.RoleManager:getLvlUpVoByLvl(lvl)
        addStamina = addStamina + lvlVo.addStamina
    end
    self.mTxtAddStamina.text = _TT(25111) --.. HtmlUtil:color(addStamina, '1c58f0ff')--"获得体力"
    self.mTxtNumStamina.text = addStamina
    local change = roleLvlUpVo.maxStamina - oldLvlVo.maxStamina
    self.mTxtMaxStamina.text = _TT(25112)
    self.mTxtOldStamina.text = oldLvlVo.maxStamina
    local newValue = oldLvlVo.maxStamina + change
    self.mTxtNewStamina.text = newValue

end

function updateExp(self)
    local roleVo = role.RoleManager:getRoleVo()
    self.mTxtExp.text = string.format("<color='#264dd5'>%s</color>/%s", roleVo:getPlayerExp(), roleVo:getPlayerMaxExp())
    self.mProgressBar:SetValue(roleVo:getPlayerExp(), roleVo:getPlayerMaxExp(), true)
end

-- function doEnterAction(self)
--     gs.TransQuick:LPosX(self.mImgAct, -1279)
--     TweenFactory:move2LPosX(self.mImgAct, -377, 0.1)
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]