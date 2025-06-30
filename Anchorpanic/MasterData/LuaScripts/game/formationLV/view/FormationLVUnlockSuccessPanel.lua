module("formationLV.FormationLVUnlockSuccessPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("pet/PetUnlockSuccessPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mPetItem = nil
    self.mCloseSn = nil
end

function open(self, args, isReshow)
    super.open(self, args, isReshow)
    local OpenSoundPath = self:getOpenSoundPath()
    if not string.NullOrEmpty(OpenSoundPath) then
        AudioManager:playSoundEffect(OpenSoundPath)
    end
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_basic_gain.prefab")
end

function configUI(self)
    super.configUI()
    -- self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtPetName = self:getChildGO("mTxtPetName"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
    self.mPetNode = self:getChildTrans("mPetNode"):GetComponent(ty.AutoRefImage)
    self.mAni = self.UIObject:GetComponent(ty.Animator)
end

function getOpenSoundPath(self)
    return UrlManager:getUIBaseSoundPath("ui_basic_gain.prefab")
end

function initViewText(self)
    -- self.mTxtTitle.text = "解锁新宠物"
end

function active(self, args)
    super.active(self, args)
    self.mId = args
    self.mPetConfig = formationLV.FormationLVManager:getLVConfigVo(self.mId)
    self:updateView()
    self.mCloseSn = nil
end

function deActive(self)
    super.deActive(self)
    self:clearItem()
end

function close(self)
    if self.mAni then 
        if self.mCloseSn then
            return
        else
            self.mAni:SetTrigger("exit")
            self.mCloseSn = LoopManager:addTimer(0.2, 1, self, function()
                LoopManager:removeTimerByIndex(self.mCloseSn)
                self.mCloseSn = nil
                super.close(self)
            end)
        end
    else
        super.close(self)
    end
end

function updateView(self)
    self:clearItem()
    self.mTxtPetName.text = self.mPetConfig:getName()
    self.mTxtSkillDesc.text = self.mPetConfig:getEffect(1)
    self.mPetNode:SetImg(UrlManager:getIconPath(self.mPetConfig.mPetPic), true)
end

function clearItem(self)
    if self.mPetItem then
        self.mPetItem:poolRecover()
    end
    self.mPetItem = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
