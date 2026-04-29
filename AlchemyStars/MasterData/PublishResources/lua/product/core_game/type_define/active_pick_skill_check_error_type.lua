ActivePickSkillCheckErrorType = {
  None = 0,
  NoActivePickCmpt = 1,
  PickPosListEmpty = 2,
  AutoPickFail = 3,
  AutoPickFailEmpty = 4,
  AutoPickCalcListEmpty = 5,
  AutoPickInsInvalid = 6,
  AutoPickInsRepeat = 7,
  AutoPickStateError = 8,
  PetNotReady = 9
}
ActivePickSkillCheckErrorType = ActivePickSkillCheckErrorType
_enum("ActivePickSkillCheckErrorType", ActivePickSkillCheckErrorType)
ActivePickSkillCheckErrorStep = {
  SendBeforeDoIns = 1,
  SendBeforeAfterDoIns = 2,
  TrySend = 3,
  AutoPickOnStateError = 4,
  AutoPickOnPickError = 5,
  PickInsRepeat = 6,
  PickInsInvalid = 7,
  PickLineAndDirectionInsRepeat = 8,
  PickLineAndDirectionInsInvalid = 9,
  PickAndDirectionInsRepeat = 10,
  PickAndDirectionInsInvalid = 11,
  PickAndDirectionInsDirInvalid = 12,
  PickPosAndRotateInsInvalid = 13,
  PickDirectionInsInvalid = 14,
  PickDiffPowerInsRepeat = 15,
  PickDiffPowerInsInvalid = 16,
  PickAndTelInsRepeat = 17,
  PickAndTelInsInvalid = 18,
  PickAndTelInsMonsterError = 19,
  PickAndTelInsCanNotTel = 20,
  PickYeliyaRepeat = 21,
  PickYeliyaInvalid = 22
}
ActivePickSkillCheckErrorStep = ActivePickSkillCheckErrorStep
_enum("ActivePickSkillCheckErrorStep", ActivePickSkillCheckErrorStep)
