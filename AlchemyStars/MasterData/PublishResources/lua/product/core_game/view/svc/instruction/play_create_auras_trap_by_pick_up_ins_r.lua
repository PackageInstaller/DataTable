LuaS �

xV           (w@l@../PublishResources/lua/product/core_game/view/svc/instruction/play_create_auras_trap_by_pick_up_ins_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@��& �    requirebase_ins_r_class'PlayCreateAurasTrapByPickUpInstructionBaseInstructionConstructorGetCacheResourceDoInstruction_PlayAuras	_PlayFly_DoFly_PlayAnimation               E   �@@ ǀ� �� 
� ��@@ � � �� �@    ��@ 
����@@ ��� �� 
� �� � ƀB ���  A 䀀
����@@ �� � �@    ��� 
����@@ A� � �@    ��� 
� ��@@ � � �@    ��� 
����@@ �� � �@    ��@ 
����@@ � � 
����@@ �� � �@    ��� 
���� � ƀB ���  A 䀀
���& �    _trapID	tonumbertrapID_trapEffDelayTimetrapEffDelay        _trapEffID
trapEffIDtrapAnimNames_trapAnimNamesstringsplit|_flyStartOffsetflyStartOffset       _flyRotateOffsetflyRotateOffset333333ӿ_flyStartHeightflyStartHeight_flyEffDelayTimeflyEffDelay
_flyEffID	flyEffID_flyTotalTimeflyTotalTime�      flyAnimNames_flyAnimNames         E               
   
   
   
   
   
   
                                                                                                                                                                                    self    E   
paramList    E   	strArray   E      _ENV    1    <   K   � @ �   ���@@ ��@� @ �� �   @���@ A� ��BA �A@� � ��� �B $B��  jA�� B �   @��@@ �@B� B �� �   ���@A ǀ� � K �A�� kA �@���B �   @��@@ �@BǀB �� �   ���@A ǀ� � K �A�� kA �@�f  & �    _trapIDCfg	cfg_trapipairsResPathtableinsert       _trapEffIDcfg_effect
_flyEffID         <                                                                                   $   $   $   %   %   %   %   &   &   '   '   '   '   '   '   '   '   *   *   *   +   +   +   +   ,   ,   -   -   -   -   -   -   -   -   0   1   
   self    <   t   <   cfgTrap      (for generator)      (for state)      (for control)      i      resPath      cfgEff   )   cfgEff0   :      _ENV 5   u    o   @$� LA@d� L��d� bA   ���@ �A�A �A & � ����A B����A   ���@ ��B �A & � � _��@���@ ��� \ �A�& � ǁBC�B�� $�  "B    �& � L��d� ��C ��B����� �BDA� 䂀���� � � $C�E$� "C   �LCEdC LEd�  �L�E ��   @�� d� �� ������F  �� �EF��F ���	� $E  �  j��G @� ���   � �   �DF�DG ���� $D  �G �G$� H� $��"D  � �DH @� $D ��& � "   GetOwnerWorldSkillRoutineGetResultContainerLogerror5PlayCreateAurasTrapByPickUp: result container is nilGetEffectResultsAsArraySkillEffectTypeCreateAurasTrapByPickUp+PlayCreateAurasTrapByPickUp: result is nil       8PlayCreateAurasTrapByPickUp: result count error, count=GetEntityByIDGetTrapEntityIDGetPosSetPositionGetSquareRingNumGetServiceTrapRenderCreateSingleTrapRenderEffectHolderAddEffectHolder	_PlayFly        ipairsAttachEffectByEffectID
_flyEffIDGetID_PlayAuras_trapEffIDTaskHelperGetInstanceIsAllTaskFinishedYIELD         o   7   7   :   :   :   :   <   <   =   =   =   =   >   B   B   B   B   C   C   D   D   D   D   E   G   G   G   H   H   H   H   H   I   M   O   O   O   O   P   P   Q   T   T   U   U   U   V   V   Z   Z   Z   [   [   [   [   [   ^   ^   _   _   `   `   a   a   a   e   e   e   e   e   e   f   f   f   g   g   g   g   h   h   h   h   h   g   g   m   m   m   m   m   m   n   n   o   o   o   o   o   r   r   r   r   r   r   r   r   s   s   s   s   u      self    o   TT    o   casterEntity    o   phaseContext    o   world   o   skillEffectResultContainer   o   resultArray   o   	skillRes"   o   trapEntity&   o   pos+   o   squareRingNum0   o   	trapRSvc3   o   effHolderCmpt:   o   flyEffEntityListG   o   taskIDsG   o   (for generator)M   U   (for state)M   U   (for control)M   U   _N   S   flyEffEntityN   S   trapEffEntity[   o      _ENV y   �    5   G@N���@�� �A@���B@� G�@  @��� �FA �� ǂ@ dB�GBA b  � �GBA ��  �& � @ ��A� ����BGCA ��� C�$� �B$� G�B�C �CC�C̓�� N�M���� ���@ ��  �C �D @��DD �C � & �    xy_trapEffDelayTime        YIELD_trapEffIDGetServiceEffectCreateWorldPositionEffectViewGetGameObject
transformVector3New       DOScale_PlayAnimation_trapAnimNames         5   z   z   {   {   |   |   }   }            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    5   TT    5   pos    5   squareRingNum    5   world    5   minX   5   maxX   5   minY   5   maxY   5   
centerPos   5   
effectSvc   5   trapEffEntity   5   
effObject"   5   
transWork#   5   scale+   5      _ENV �   �    �   K  �@�� �A@A�  䁀B@��  $��GA  @��� �F�A �� �A dB�L�Ad� �B�� �BB �������$��G�B�C M��
C��GC�N��C���������K  ��C ��D���J����C �DD���J�����C ������J����C �D����J������  E @�$ �LFEǆE   d� b   ��	��E� ����@ �GF �F ̆F @���F �F �G �F� �@��F����  �����BC ���Ɔ�� C ���F��GH �H��GH ���ʆ��F���E ���F��G GG@�	��$G�)�  ���A @� $E   FE ��	d ��J �FJ��� ��J�J @  ������G �F�  
@ �F�i�  ��@�� 
f�& � ,   GetOwnerWorldGetServiceBoardRenderEffect_flyEffDelayTime        YIELDGetRenderGridPositionGetRenderGridDirection_flyStartOffsetGridPos2RenderPosy_flyStartHeightx       Vector2      �?                     ipairsCreatePositionEffect
_flyEffID
NormalizeSetDirection_flyRotateOffset_PlayAnimation_flyAnimNamestableinsertstartHeight
endHeight
totalTime_flyTotalTime����MbP?totalTimeMstargetRenderPoscurrentTimetrajectoryIDtrajectoryEntityGameGlobalTaskManagerCoreGameStartTask_DoFly         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   $   self    �   TT    �   casterEntity    �   pos    �   squareRingNum    �   flyEffEntityList   �   world   �   	boardSvc   �   
effectSvc	   �   
casterPos   �   
casterDir   �   flyStartPos   �   v3StartPos   �   minX    �   maxX"   �   minY$   �   maxY&   �   flysquareRingNumList'   �   
centerPos<   �   trajectoryInfoArray=   �   (for generator)@   t   (for state)@   t   (for control)@   t   _A   r   endGridPosA   r   
effEntityE   r   effDirH   X   endRenderPos[   r   trajectoryInfom   r   taskIDsx   �   (for generator){   �   (for state){   �   (for control){   �   _|   �   trajectoryInfo|   �   taskID�   �      _ENV �   �       � @A�$� L�@d� ����AGBA��A�  䁀���FB GB�G��G���A��C  � GBC�A�& �    trajectoryEntityViewGetGameObject
transformDOMovetargetRenderPos
totalTimeSetEaseDG	TweeningEase	OutQuartYIELDtotalTimeMs            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       trajectoryInfo       entity      effectViewCmpt      effectObject      
transWork         _ENV �      ,   � � � �@    �& � �@� � ̀�� ���A �AA ǁ�� $�  �A@�FB GA��� ���dA�& � FC GA�� d�  @���L�CdA A� � �� h� �LD�dB�g��� �LADǁCdA�& �    HasViewViewGetGameObjectGetComponentInChildrentypeofUnityEngine
Animation Logfatal4Cant play legacy animation, animation not found in nametablecount       StopPlayQueuedPlay         ,   �   �   �   �                                          
  
  
  
  
  
                                	   self    ,   entity    ,   
animNames    ,   go	   ,   anim   ,   (for index)"   '   (for limit)"   '   (for step)"   '   i#   &      _ENV                                          1      5   u   5   y   �   y   �   �   �   �   �   �   �     �            _ENV