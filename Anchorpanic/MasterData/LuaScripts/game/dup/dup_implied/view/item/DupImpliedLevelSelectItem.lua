module("game.dup_implied.view.item.DupImpliedLevelSelectItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTitle_1 = self:getChildGO("mTitle_1"):GetComponent(ty.Text)
    self.mTitle_2 = self:getChildGO("mTitle_2"):GetComponent(ty.Text)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mSelect = self:getChildGO("mSelect")
    self.mClick = self:getChildGO("mClick")

    self.mLock = self:getChildGO("mLock")

end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.DUPIMPLIED_SELECTLEVEL, self.onSelect, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.DUPIMPLIED_SELECTLEVEL, self.onSelect, self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mClick, function()
        GameDispatcher:dispatchEvent(EventName.DUPIMPLIED_SELECTLEVEL, self.data)
    end)
end

function setData(self, data)
    super.setData(self, data)

    self.mTitle_1.text = data
    self.mTitle_2.text = _TT(4522)

    local diffVo = dup.DupImpliedManager:getStageDifficultyVo(data)
    if diffVo then
        local roleVo = role.RoleManager:getRoleVo()
        local playerLevel = roleVo:getPlayerLvl()
        local isLock = diffVo.level > playerLevel
        self.mLock:SetActive(isLock)

        local iconPath = isLock and string.format("img_degree_0%s.png", data) or string.format("img_degree_0%s.png", data)
        self.mImgIcon:SetImg(string.format("arts/ui/pack/dupImplied_new/%s", iconPath), false)
    end
end

function onSelect(self, diff_id)
    self.mSelect:SetActive(diff_id == self.data)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4522):	"难度"
]]
