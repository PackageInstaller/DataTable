LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1500151/cfg_skill_view_300015.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1500151,waitTime = 2000;�m       DataSelectResult,effectType=1,index=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=3148; PlayCasterBindEffect,effectID=3149; PlayCreateCasterGhost,DisableAlpha=1,Type=PickUpRotate,Prefab=1500152.prefab,Anim=AtkUlt,BornEffectID=3150; PlayAudio,audioID = 2368; Wait,waitTime=3900; PlayDeleteGhost; �	      � DataSelectResult,effectType=1,index=1; PlayCasterToPickupToReflect,effectID=3151,flyTime=260,flySpeed=33; PlayAudio,audioID = 3009; � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3152,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=33; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV