local SkillTriggerArg = class("LuaTriggerArg")

function SkillTriggerArg:ctor()
end

function SkillTriggerArg:SetArgs(sender, target, senderBelongNum, targetBelongNum, senderRoleType, targetRoleType, verifyId, extraArg1, extraArg2, extraArg3)
  self.sender = sender
  self.target = target
  self.senderBelongNum = senderBelongNum or -1
  self.targetBelongNum = targetBelongNum or -1
  self.senderRoleType = senderRoleType or 0
  self.targetRoleType = targetRoleType or 0
  self.verifyId = verifyId or 0
  self.extraArg1 = extraArg1 or -1
  self.extraArg2 = extraArg2 or -1
  self.extraArg3 = extraArg3 or -1
end

function SkillTriggerArg:SetArgsForTable(args)
  self.sender = args.sender
  self.target = args.target
  self.senderBelongNum = args.senderBelongNum or -1
  self.targetBelongNum = args.targetBelongNum or -1
  self.senderRoleType = args.senderRoleType or 0
  self.targetRoleType = args.targetRoleType or 0
  self.verifyId = args.verifyId or 0
  self.extraArg1 = args.extraArg1 or -1
  self.extraArg2 = args.extraArg2 or -1
  self.extraArg3 = args.extraArg3 or -1
end

return SkillTriggerArg
