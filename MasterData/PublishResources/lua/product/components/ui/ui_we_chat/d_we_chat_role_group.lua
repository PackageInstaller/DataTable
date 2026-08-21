_class("DWeChatRoleGroup", Object)
DWeChatRoleGroup = DWeChatRoleGroup

function DWeChatRoleGroup:Constructor()
  self._roleList = {}
  self._idx = 1
end

function DWeChatRoleGroup:CurrentIdx()
  return self._idx
end

function DWeChatRoleGroup:SetIdx(idx)
  self._idx = idx
end

function DWeChatRoleGroup:GroupID()
  return self._roleList[1]:GetGroupId()
end

function DWeChatRoleGroup:AddRole(role)
  table.insert(self._roleList, role)
end

function DWeChatRoleGroup:RoleList()
  return self._roleList
end

function DWeChatRoleGroup:RoleCount()
  return #self._roleList
end

function DWeChatRoleGroup:AddIdx()
  self._idx = self._idx + 1
  if self._idx > #self._roleList then
    self._idx = 1
  end
end

function DWeChatRoleGroup:CurrentRole()
  return self._roleList[self._idx]
end
