LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2000231/cfg_skill_view_500228.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName=Absorb; PlayAudio,audioID = 7013,audioType=1; PlayAbsorbPieceEffect,flyEffectID=817,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=150,targetPos=Hit,waitFlyEffectTime=800; PlayCasterBindEffect,effectID=821; Wait,waitTime=1000; �      �       DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayCasterAnimation,animName=Atk; PlayAudio,audioID = 7012,audioType=1; Wait,waitTime=400; Jump,condition=CheckAbsortPieceCountLessThan,param=3,goto=effect1; Jump,condition=CheckTrue,goto=pieceCount1; PlayCasterBindEffect,effectID=787,label=effect1; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=793,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType= InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=805,turnToTarget=1,deathClear=0; Jump,condition=CheckTrue,goto=phaseEnd; Jump,condition=CheckAbsortPieceCountLessThan,param=6,goto=effect2,label=pieceCount1; Jump,condition=CheckTrue,goto=pieceCount2; PlayCasterBindEffect,effectID=787,label=effect2; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=792,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType= InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=804,turnToTarget=1,deathClear=0; Jump,condition=CheckTrue,goto=phaseEnd; PlayCasterBindEffect,effectID=787,label=pieceCount2; PlayCasterTurnToTarget; PlayFlyEffectCasterToTarget,flyEffectID=791,flySpeed=150,flyTrace=1,offsety=1,offsetz=0.5,flyEaseType= InCirc,targetPos=Hit; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=803,turnToTarget=1,deathClear=0;         %                                                                                                                     key   %   config    %      _ENV