LuaS �

xV           (w@f@../PublishResources/config/shared/skill/skill_view/chessPet/pet/15011410/cfg_skill_view_15011410.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName=AtkUlt; PlayAudio,audioID = 2316,audioType=1; PlayTurnToTeleportNewPos; PlayCasterChangeMaterial,type=0,part=1,mat=eff_1501141_weaponMatAnim.mat,nodeName=1501141_weapon; PlayCasterChangeMaterial,type=0,part=1,mat=eff_1501141_weaponMatAnim.mat,nodeName=1501142_weapon; PlayCasterBindEffect,effectID=2611; PlayCasterBindEffect,effectID=2612; Wait,waitTime=200; PlayCameraEffect,effectID=2614; Wait,waitTime=5600; �      ��       PlayChessKnightTeleport; Wait,waitTime=1200; PlayCasterBindEffect,effectID =2613; Wait,waitTime=200; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayTurnToChessKnight; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayTurnToChessKnight; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=playRangeEffect; Wait,waitTime=1800; PlayTeleportResultTarget,type=5; PlayCasterChangeMaterial,type=1,part=1,nodeName=1501141_weapon; PlayCasterChangeMaterial,type=1,part=1,nodeName=1501142_weapon;  PlayModifyTimeScale,type=0;         0                                                                                                                                                      key   0   config+   0      _ENV