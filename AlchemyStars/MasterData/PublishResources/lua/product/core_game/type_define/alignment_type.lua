AlignmentType = {
  LocalPlayer = 1,
  Monster = 2,
  Goodness = 3,
  Wickedness = 4,
  Punishment = 5
}
AlignmentTargetType = {Friend = 1, Enemy = 2}

function MatchAlignmentType(casterAlignmentType, targetAlignmentType)
  if casterAlignmentType == targetAlignmentType then
    return AlignmentTargetType.Friend
  end
  if casterAlignmentType == AlignmentType.Goodness or targetAlignmentType == AlignmentType.Goodness then
    return AlignmentTargetType.Friend
  end
  if casterAlignmentType == AlignmentType.Punishment then
    return AlignmentTargetType.Enemy
  end
  if targetAlignmentType == AlignmentType.Punishment then
    return AlignmentTargetType.Friend
  end
  if casterAlignmentType == AlignmentType.Wickedness or targetAlignmentType == AlignmentType.Wickedness then
    return AlignmentTargetType.Enemy
  end
  if casterAlignmentType == AlignmentType.LocalPlayer and targetAlignmentType == AlignmentType.Monster then
    return AlignmentTargetType.Enemy
  end
  if casterAlignmentType == AlignmentType.Monster and targetAlignmentType == AlignmentType.LocalPlayer then
    return AlignmentTargetType.Enemy
  end
  return AlignmentTargetType.Enemy
end
