return {
	Play102092001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102092001
		arg_1_1.duration_ = 3.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102092002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_fight_metal", "")
			end

			local var_4_3 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["1084ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_8 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_8 and not isNil(var_4_7) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_7) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_8 and arg_1_1.time_ < 2 + var_4_8 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_10 = "B02c"

			if arg_1_1.bgs_.B02c == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.B02c:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueB02c = var_4_12.color.a
					arg_1_1.var_.alphaMatValueB02c = var_4_12
				end

				arg_1_1.var_.alphaOldValueB02c = 0
			end

			local var_4_13 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				if arg_1_1.var_.alphaMatValueB02c then
					arg_1_1.var_.alphaMatValueB02c.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02c, 1, (arg_1_1.time_ - 0) / var_4_13)
					arg_1_1.var_.alphaMatValueB02c.color = arg_1_1.var_.alphaMatValueB02c.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueB02c then
				arg_1_1.var_.alphaMatValueB02c.color.a = 1
				arg_1_1.var_.alphaMatValueB02c.color = arg_1_1.var_.alphaMatValueB02c.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.B02c

				arg_1_1.bgs_.B02c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_4_17 = arg_1_1.actors_["1084ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_17.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_4_18 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 1.8) / var_4_18)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(0, -0.97, -6)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			local var_4_19 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_19 + 2 and arg_1_1.time_ < var_4_19 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(102092001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 5 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 5)

				if (5 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 5)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092001", "story_v_out_102092.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_102092", "102092001", "story_v_out_102092.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_102092", "102092001", "story_v_out_102092.awb")

						arg_1_1:RecordAudio("102092001", var_4_28)
						arg_1_1:RecordAudio("102092001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102092", "102092001", "story_v_out_102092.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102092", "102092001", "story_v_out_102092.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play102092002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 102092002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play102092003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1084ui_story"]) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = arg_7_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1084ui_story"]) then
				if arg_7_1.var_.characterEffect1084ui_story and not isNil(arg_7_1.actors_["1084ui_story"]) then
					arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1084ui_story"]) and arg_7_1.var_.characterEffect1084ui_story then
				arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 1.15

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(102092002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 45 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 45)

				if (45 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 45)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_6 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_6 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_6

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_6 and arg_7_1.time_ < var_10_1 + var_10_6 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play102092003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 102092003
		arg_11_1.duration_ = 6.73

		local var_11_0 = {
			ja = 6.733,
			ko = 5.4,
			zh = 3.9,
			en = 4.933
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play102092004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_14_2 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_11_1.bgmTxt_.text ~= var_14_2 and arg_11_1.bgmTxt_.text ~= "" then
						if arg_11_1.bgmTxt2_.text ~= "" then
							arg_11_1.bgmTxt_.text = arg_11_1.bgmTxt2_.text
						end

						arg_11_1.bgmTxt2_.text = var_14_2

						arg_11_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_11_1.bgmTxt_.text = var_14_2
						arg_11_1.bgmTxt2_.text = var_14_2
					end

					if arg_11_1.bgmTimer then
						arg_11_1.bgmTimer:Stop()

						arg_11_1.bgmTimer = nil
					end

					if arg_11_1.settingData.show_music_name == 1 then
						arg_11_1.musicController:SetSelectedState("show")
						arg_11_1.musicAnimator_:Play("open", 0, 0)

						if arg_11_1.settingData.music_time ~= 0 then
							arg_11_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_11_1.settingData.music_time), function()
								if arg_11_1 == nil or isNil(arg_11_1.bgmTxt_) then
									return
								end

								arg_11_1.musicController:SetSelectedState("hide")
								arg_11_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_14_3 = "10002ui_story"

			if arg_11_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_14_4 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_11_1.stage_.transform)

				var_14_4.name = var_14_3
				var_14_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_3] = var_14_4

				local var_14_5 = var_14_4:GetComponentInChildren(typeof(CharacterEffect))

				var_14_5.enabled = true

				local var_14_6 = GameObjectTools.GetOrAddComponent(var_14_4, typeof(DynamicBoneHelper))

				if var_14_6 then
					var_14_6:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_5.transform, false)

				arg_11_1.var_[var_14_3 .. "Animator"] = var_14_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_3 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_3 .. "LipSync"] = var_14_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_7 = arg_11_1.actors_["10002ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_7) and arg_11_1.var_.characterEffect10002ui_story == nil then
				arg_11_1.var_.characterEffect10002ui_story = var_14_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_8 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_8 and not isNil(var_14_7) then
				if arg_11_1.var_.characterEffect10002ui_story and not isNil(var_14_7) then
					arg_11_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_8 and arg_11_1.time_ < 0 + var_14_8 + arg_14_0 and not isNil(var_14_7) and arg_11_1.var_.characterEffect10002ui_story then
				arg_11_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_14_10 = arg_11_1.actors_["1084ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1084ui_story = var_14_10.localPosition
			end

			local var_14_11 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_11 then
				var_14_10.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_11)
				var_14_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_10.position).x, (manager.ui.mainCamera.transform.position - var_14_10.position).y, (manager.ui.mainCamera.transform.position - var_14_10.position).z)
				var_14_10.localEulerAngles.z = 0
				var_14_10.localEulerAngles.x = 0
				var_14_10.localEulerAngles = var_14_10.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_11 and arg_11_1.time_ < 0 + var_14_11 + arg_14_0 then
				var_14_10.localPosition = Vector3.New(0, 100, 0)
				var_14_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_10.position).x, (manager.ui.mainCamera.transform.position - var_14_10.position).y, (manager.ui.mainCamera.transform.position - var_14_10.position).z)
				var_14_10.localEulerAngles.z = 0
				var_14_10.localEulerAngles.x = 0
				var_14_10.localEulerAngles = var_14_10.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_14_12 = arg_11_1.actors_["10002ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos10002ui_story = var_14_12.localPosition
			end

			local var_14_13 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_13 then
				var_14_12.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_11_1.time_ - 0) / var_14_13)
				var_14_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_12.position).x, (manager.ui.mainCamera.transform.position - var_14_12.position).y, (manager.ui.mainCamera.transform.position - var_14_12.position).z)
				var_14_12.localEulerAngles.z = 0
				var_14_12.localEulerAngles.x = 0
				var_14_12.localEulerAngles = var_14_12.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_13 and arg_11_1.time_ < 0 + var_14_13 + arg_14_0 then
				var_14_12.localPosition = Vector3.New(0, -1.2, -5.8)
				var_14_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_12.position).x, (manager.ui.mainCamera.transform.position - var_14_12.position).y, (manager.ui.mainCamera.transform.position - var_14_12.position).z)
				var_14_12.localEulerAngles.z = 0
				var_14_12.localEulerAngles.x = 0
				var_14_12.localEulerAngles = var_14_12.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_14_14 = 0
			local var_14_15 = 0.425

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_16 = arg_11_1:GetWordFromCfg(102092003)
				local var_14_17 = arg_11_1:FormatText(var_14_16.content)

				arg_11_1.text_.text = var_14_17

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_19 = 17 <= 0 and var_14_15 or var_14_15 * (utf8.len(var_14_17) / 17)

				if (17 <= 0 and var_14_15 or var_14_15 * (utf8.len(var_14_17) / 17)) > 0 and var_14_15 < var_14_19 then
					arg_11_1.talkMaxDuration = var_14_19

					if var_14_19 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_19 + var_14_14
					end
				end

				arg_11_1.text_.text = var_14_17
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092003", "story_v_out_102092.awb") ~= 0 then
					local var_14_20 = manager.audio:GetVoiceLength("story_v_out_102092", "102092003", "story_v_out_102092.awb") / 1000

					if var_14_20 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_20 + var_14_14
					end

					if var_14_16.prefab_name ~= "" and arg_11_1.actors_[var_14_16.prefab_name] ~= nil then
						local var_14_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_16.prefab_name].transform, "story_v_out_102092", "102092003", "story_v_out_102092.awb")

						arg_11_1:RecordAudio("102092003", var_14_21)
						arg_11_1:RecordAudio("102092003", var_14_21)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_102092", "102092003", "story_v_out_102092.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_102092", "102092003", "story_v_out_102092.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_22 = math.max(var_14_15, arg_11_1.talkMaxDuration)

			if var_14_14 <= arg_11_1.time_ and arg_11_1.time_ < var_14_14 + var_14_22 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_14) / var_14_22

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_14 + var_14_22 and arg_11_1.time_ < var_14_14 + var_14_22 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play102092004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102092004
		arg_16_1.duration_ = 7.53

		local var_16_0 = {
			ja = 7.166,
			ko = 7.533,
			zh = 5.866,
			en = 5.833
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play102092005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1084ui_story"]) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = arg_16_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1084ui_story"]) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(arg_16_1.actors_["1084ui_story"]) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1084ui_story"]) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["10002ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect10002ui_story == nil then
				arg_16_1.var_.characterEffect10002ui_story = var_19_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_3 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.characterEffect10002ui_story and not isNil(var_19_2) then
					arg_16_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_16_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_3)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect10002ui_story then
				arg_16_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_16_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_4.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_4.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_16_1.time_ - 0) / var_19_5)
				var_19_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_4.position).x, (manager.ui.mainCamera.transform.position - var_19_4.position).y, (manager.ui.mainCamera.transform.position - var_19_4.position).z)
				var_19_4.localEulerAngles.z = 0
				var_19_4.localEulerAngles.x = 0
				var_19_4.localEulerAngles = var_19_4.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_19_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_4.position).x, (manager.ui.mainCamera.transform.position - var_19_4.position).y, (manager.ui.mainCamera.transform.position - var_19_4.position).z)
				var_19_4.localEulerAngles.z = 0
				var_19_4.localEulerAngles.x = 0
				var_19_4.localEulerAngles = var_19_4.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_19_6 = arg_16_1.actors_["10002ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10002ui_story = var_19_6.localPosition
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_16_1.time_ - 0) / var_19_7)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, -1.2, -5.8)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			local var_19_8 = arg_16_1.actors_["10002ui_story"].transform

			if 0.033 < arg_16_1.time_ and arg_16_1.time_ <= 0.033 + arg_19_0 then
				arg_16_1.var_.moveOldPos10002ui_story = var_19_8.localPosition
			end

			local var_19_9 = 0.5

			if 0.033 <= arg_16_1.time_ and arg_16_1.time_ < 0.033 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_16_1.time_ - 0.033) / var_19_9)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0.033 + var_19_9 and arg_16_1.time_ < 0.033 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_19_10 = 0
			local var_19_11 = 0.675

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(102092004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 27 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 27)

				if (27 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 27)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092004", "story_v_out_102092.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_102092", "102092004", "story_v_out_102092.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_102092", "102092004", "story_v_out_102092.awb")

						arg_16_1:RecordAudio("102092004", var_19_17)
						arg_16_1:RecordAudio("102092004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102092", "102092004", "story_v_out_102092.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102092", "102092004", "story_v_out_102092.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play102092005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102092005
		arg_20_1.duration_ = 6.5

		local var_20_0 = {
			ja = 4.166,
			ko = 6.5,
			zh = 4.9,
			en = 4.7
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play102092006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["10002ui_story"]) and arg_20_1.var_.characterEffect10002ui_story == nil then
				arg_20_1.var_.characterEffect10002ui_story = arg_20_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["10002ui_story"]) then
				if arg_20_1.var_.characterEffect10002ui_story and not isNil(arg_20_1.actors_["10002ui_story"]) then
					arg_20_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["10002ui_story"]) and arg_20_1.var_.characterEffect10002ui_story then
				arg_20_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1084ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_4 = 0
			local var_23_5 = 0.5

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(102092005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 20 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 20)

				if (20 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 20)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092005", "story_v_out_102092.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092005", "story_v_out_102092.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_102092", "102092005", "story_v_out_102092.awb")

						arg_20_1:RecordAudio("102092005", var_23_11)
						arg_20_1:RecordAudio("102092005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102092", "102092005", "story_v_out_102092.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102092", "102092005", "story_v_out_102092.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102092006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102092006
		arg_24_1.duration_ = 15.9

		local var_24_0 = {
			ja = 13.533,
			ko = 15.9,
			zh = 11.433,
			en = 11.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play102092007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = arg_24_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(arg_24_1.actors_["1084ui_story"]) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1084ui_story"]) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action424")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_27_1 = 0
			local var_27_2 = 1.2

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:GetWordFromCfg(102092006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 49 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 49)

				if (49 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_4) / 49)) > 0 and var_27_2 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092006", "story_v_out_102092.awb") ~= 0 then
					local var_27_7 = manager.audio:GetVoiceLength("story_v_out_102092", "102092006", "story_v_out_102092.awb") / 1000

					if var_27_7 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_1
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_102092", "102092006", "story_v_out_102092.awb")

						arg_24_1:RecordAudio("102092006", var_27_8)
						arg_24_1:RecordAudio("102092006", var_27_8)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102092", "102092006", "story_v_out_102092.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102092", "102092006", "story_v_out_102092.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_9 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_9 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_9

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_9 and arg_24_1.time_ < var_27_1 + var_27_9 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play102092007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102092007
		arg_28_1.duration_ = 5.8

		local var_28_0 = {
			ja = 5.8,
			ko = 4.633,
			zh = 4,
			en = 4.766
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play102092008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1011ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1011ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1011ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1011ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1011ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1011ui_story == nil then
				arg_28_1.var_.characterEffect1011ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1011ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1011ui_story then
				arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_31_6 = arg_28_1.actors_["10002ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect10002ui_story == nil then
				arg_28_1.var_.characterEffect10002ui_story = var_31_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 and not isNil(var_31_6) then
				if arg_28_1.var_.characterEffect10002ui_story and not isNil(var_31_6) then
					arg_28_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_7)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect10002ui_story then
				arg_28_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_31_8 = arg_28_1.actors_["1084ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, 100, 0)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			local var_31_10 = arg_28_1.actors_["1011ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1011ui_story = var_31_10.localPosition
			end

			local var_31_11 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_11 then
				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_28_1.time_ - 0) / var_31_11)
				var_31_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_10.position).x, (manager.ui.mainCamera.transform.position - var_31_10.position).y, (manager.ui.mainCamera.transform.position - var_31_10.position).z)
				var_31_10.localEulerAngles.z = 0
				var_31_10.localEulerAngles.x = 0
				var_31_10.localEulerAngles = var_31_10.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_11 and arg_28_1.time_ < 0 + var_31_11 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_31_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_10.position).x, (manager.ui.mainCamera.transform.position - var_31_10.position).y, (manager.ui.mainCamera.transform.position - var_31_10.position).z)
				var_31_10.localEulerAngles.z = 0
				var_31_10.localEulerAngles.x = 0
				var_31_10.localEulerAngles = var_31_10.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_12 = 0
			local var_31_13 = 0.425

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(102092007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 17 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 17)

				if (17 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 17)) > 0 and var_31_13 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092007", "story_v_out_102092.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_102092", "102092007", "story_v_out_102092.awb") / 1000

					if var_31_18 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_12
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_102092", "102092007", "story_v_out_102092.awb")

						arg_28_1:RecordAudio("102092007", var_31_19)
						arg_28_1:RecordAudio("102092007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102092", "102092007", "story_v_out_102092.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102092", "102092007", "story_v_out_102092.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_20 and arg_28_1.time_ < var_31_12 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play102092008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102092008
		arg_32_1.duration_ = 2.6

		local var_32_0 = {
			ja = 2.466,
			ko = 1.999999999999,
			zh = 2.6,
			en = 1.999999999999
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play102092009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10002ui_story"]) and arg_32_1.var_.characterEffect10002ui_story == nil then
				arg_32_1.var_.characterEffect10002ui_story = arg_32_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10002ui_story"]) then
				if arg_32_1.var_.characterEffect10002ui_story and not isNil(arg_32_1.actors_["10002ui_story"]) then
					arg_32_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10002ui_story"]) and arg_32_1.var_.characterEffect10002ui_story then
				arg_32_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1011ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1011ui_story == nil then
				arg_32_1.var_.characterEffect1011ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1011ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1011ui_story then
				arg_32_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.05

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(102092008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 2 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 2)

				if (2 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 2)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092008", "story_v_out_102092.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092008", "story_v_out_102092.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_102092", "102092008", "story_v_out_102092.awb")

						arg_32_1:RecordAudio("102092008", var_35_11)
						arg_32_1:RecordAudio("102092008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102092", "102092008", "story_v_out_102092.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102092", "102092008", "story_v_out_102092.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play102092009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102092009
		arg_36_1.duration_ = 5.7

		local var_36_0 = {
			ja = 4.466,
			ko = 5.7,
			zh = 4.066,
			en = 4.1
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play102092010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action4_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_39_0 = 0
			local var_39_1 = 0.475

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(102092009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 19 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 19)

				if (19 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 19)) > 0 and var_39_1 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092009", "story_v_out_102092.awb") ~= 0 then
					local var_39_6 = manager.audio:GetVoiceLength("story_v_out_102092", "102092009", "story_v_out_102092.awb") / 1000

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end

					if var_39_2.prefab_name ~= "" and arg_36_1.actors_[var_39_2.prefab_name] ~= nil then
						local var_39_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_2.prefab_name].transform, "story_v_out_102092", "102092009", "story_v_out_102092.awb")

						arg_36_1:RecordAudio("102092009", var_39_7)
						arg_36_1:RecordAudio("102092009", var_39_7)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102092", "102092009", "story_v_out_102092.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102092", "102092009", "story_v_out_102092.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play102092010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102092010
		arg_40_1.duration_ = 16.53

		local var_40_0 = {
			ja = 9.1,
			ko = 16.533,
			zh = 11.9,
			en = 9.2
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play102092011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_43_0 = 0
			local var_43_1 = 1.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(102092010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 52 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 52)

				if (52 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 52)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092010", "story_v_out_102092.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_102092", "102092010", "story_v_out_102092.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_102092", "102092010", "story_v_out_102092.awb")

						arg_40_1:RecordAudio("102092010", var_43_7)
						arg_40_1:RecordAudio("102092010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102092", "102092010", "story_v_out_102092.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102092", "102092010", "story_v_out_102092.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play102092011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102092011
		arg_44_1.duration_ = 2.3

		local var_44_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.3
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play102092012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = arg_44_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(arg_44_1.actors_["1084ui_story"]) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1084ui_story"]) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["10002ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect10002ui_story == nil then
				arg_44_1.var_.characterEffect10002ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect10002ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect10002ui_story then
				arg_44_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_47_4 = arg_44_1.actors_["1011ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1011ui_story = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_5)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, 100, 0)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_47_6 = arg_44_1.actors_["1084ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_6.localPosition
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_44_1.time_ - 0) / var_47_7)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_8 = 0
			local var_47_9 = 0.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(102092011)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_13 = 5 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 5)

				if (5 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 5)) > 0 and var_47_9 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092011", "story_v_out_102092.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_102092", "102092011", "story_v_out_102092.awb") / 1000

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end

					if var_47_10.prefab_name ~= "" and arg_44_1.actors_[var_47_10.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_10.prefab_name].transform, "story_v_out_102092", "102092011", "story_v_out_102092.awb")

						arg_44_1:RecordAudio("102092011", var_47_15)
						arg_44_1:RecordAudio("102092011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102092", "102092011", "story_v_out_102092.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102092", "102092011", "story_v_out_102092.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_16 and arg_44_1.time_ < var_47_8 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play102092012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102092012
		arg_48_1.duration_ = 20.13

		local var_48_0 = {
			ja = 15.833,
			ko = 20.133,
			zh = 14.9,
			en = 16.133
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play102092013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = arg_48_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) then
				if arg_48_1.var_.characterEffect10002ui_story and not isNil(arg_48_1.actors_["10002ui_story"]) then
					arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) and arg_48_1.var_.characterEffect10002ui_story then
				arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1084ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_51_4 = 0
			local var_51_5 = 1.6

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(102092012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 64 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 64)

				if (64 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 64)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092012", "story_v_out_102092.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092012", "story_v_out_102092.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_102092", "102092012", "story_v_out_102092.awb")

						arg_48_1:RecordAudio("102092012", var_51_11)
						arg_48_1:RecordAudio("102092012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102092", "102092012", "story_v_out_102092.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102092", "102092012", "story_v_out_102092.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play102092013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102092013
		arg_52_1.duration_ = 3.83

		local var_52_0 = {
			ja = 3.833,
			ko = 2.4,
			zh = 2.5,
			en = 2.2
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play102092014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = arg_52_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(arg_52_1.actors_["1084ui_story"]) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1084ui_story"]) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["10002ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10002ui_story then
				arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.125

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(102092013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 5 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 5)

				if (5 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 5)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092013", "story_v_out_102092.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092013", "story_v_out_102092.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_102092", "102092013", "story_v_out_102092.awb")

						arg_52_1:RecordAudio("102092013", var_55_11)
						arg_52_1:RecordAudio("102092013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102092", "102092013", "story_v_out_102092.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102092", "102092013", "story_v_out_102092.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play102092014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102092014
		arg_56_1.duration_ = 12.47

		local var_56_0 = {
			ja = 12.466,
			ko = 12,
			zh = 11.7,
			en = 11.3
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play102092015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10002ui_story"]) and arg_56_1.var_.characterEffect10002ui_story == nil then
				arg_56_1.var_.characterEffect10002ui_story = arg_56_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10002ui_story"]) then
				if arg_56_1.var_.characterEffect10002ui_story and not isNil(arg_56_1.actors_["10002ui_story"]) then
					arg_56_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10002ui_story"]) and arg_56_1.var_.characterEffect10002ui_story then
				arg_56_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1084ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_59_4 = arg_56_1.actors_["1084ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_4.localPosition
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_5)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(0, 100, 0)
				var_59_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_4.position).x, (manager.ui.mainCamera.transform.position - var_59_4.position).y, (manager.ui.mainCamera.transform.position - var_59_4.position).z)
				var_59_4.localEulerAngles.z = 0
				var_59_4.localEulerAngles.x = 0
				var_59_4.localEulerAngles = var_59_4.localEulerAngles
			end

			local var_59_6 = arg_56_1.actors_["10002ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10002ui_story = var_59_6.localPosition
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_56_1.time_ - 0) / var_59_7)
				var_59_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_6.position).x, (manager.ui.mainCamera.transform.position - var_59_6.position).y, (manager.ui.mainCamera.transform.position - var_59_6.position).z)
				var_59_6.localEulerAngles.z = 0
				var_59_6.localEulerAngles.x = 0
				var_59_6.localEulerAngles = var_59_6.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_59_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_6.position).x, (manager.ui.mainCamera.transform.position - var_59_6.position).y, (manager.ui.mainCamera.transform.position - var_59_6.position).z)
				var_59_6.localEulerAngles.z = 0
				var_59_6.localEulerAngles.x = 0
				var_59_6.localEulerAngles = var_59_6.localEulerAngles
			end

			local var_59_8 = arg_56_1.actors_["10002ui_story"].transform

			if 0.033 < arg_56_1.time_ and arg_56_1.time_ <= 0.033 + arg_59_0 then
				arg_56_1.var_.moveOldPos10002ui_story = var_59_8.localPosition
			end

			local var_59_9 = 0.5

			if 0.033 <= arg_56_1.time_ and arg_56_1.time_ < 0.033 + var_59_9 then
				var_59_8.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_56_1.time_ - 0.033) / var_59_9)
				var_59_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_8.position).x, (manager.ui.mainCamera.transform.position - var_59_8.position).y, (manager.ui.mainCamera.transform.position - var_59_8.position).z)
				var_59_8.localEulerAngles.z = 0
				var_59_8.localEulerAngles.x = 0
				var_59_8.localEulerAngles = var_59_8.localEulerAngles
			end

			if arg_56_1.time_ >= 0.033 + var_59_9 and arg_56_1.time_ < 0.033 + var_59_9 + arg_59_0 then
				var_59_8.localPosition = Vector3.New(0, -1.2, -5.8)
				var_59_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_8.position).x, (manager.ui.mainCamera.transform.position - var_59_8.position).y, (manager.ui.mainCamera.transform.position - var_59_8.position).z)
				var_59_8.localEulerAngles.z = 0
				var_59_8.localEulerAngles.x = 0
				var_59_8.localEulerAngles = var_59_8.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_59_10 = 0
			local var_59_11 = 1.175

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_12 = arg_56_1:GetWordFromCfg(102092014)
				local var_59_13 = arg_56_1:FormatText(var_59_12.content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 47 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 47)

				if (47 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 47)) > 0 and var_59_11 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092014", "story_v_out_102092.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_out_102092", "102092014", "story_v_out_102092.awb") / 1000

					if var_59_16 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_10
					end

					if var_59_12.prefab_name ~= "" and arg_56_1.actors_[var_59_12.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_12.prefab_name].transform, "story_v_out_102092", "102092014", "story_v_out_102092.awb")

						arg_56_1:RecordAudio("102092014", var_59_17)
						arg_56_1:RecordAudio("102092014", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102092", "102092014", "story_v_out_102092.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102092", "102092014", "story_v_out_102092.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_18 and arg_56_1.time_ < var_59_10 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play102092015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102092015
		arg_60_1.duration_ = 12.93

		local var_60_0 = {
			ja = 12.933,
			ko = 12.766,
			zh = 10.5,
			en = 10.4
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play102092016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_63_0 = 0
			local var_63_1 = 1.1

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(102092015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 44 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 44)

				if (44 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 44)) > 0 and var_63_1 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092015", "story_v_out_102092.awb") ~= 0 then
					local var_63_6 = manager.audio:GetVoiceLength("story_v_out_102092", "102092015", "story_v_out_102092.awb") / 1000

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_out_102092", "102092015", "story_v_out_102092.awb")

						arg_60_1:RecordAudio("102092015", var_63_7)
						arg_60_1:RecordAudio("102092015", var_63_7)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102092", "102092015", "story_v_out_102092.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102092", "102092015", "story_v_out_102092.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play102092016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102092016
		arg_64_1.duration_ = 15.2

		local var_64_0 = {
			ja = 12.333,
			ko = 13.2,
			zh = 13.9,
			en = 15.2
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play102092017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_67_0 = 0
			local var_67_1 = 1.4

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(102092016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 56 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 56)

				if (56 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 56)) > 0 and var_67_1 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092016", "story_v_out_102092.awb") ~= 0 then
					local var_67_6 = manager.audio:GetVoiceLength("story_v_out_102092", "102092016", "story_v_out_102092.awb") / 1000

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end

					if var_67_2.prefab_name ~= "" and arg_64_1.actors_[var_67_2.prefab_name] ~= nil then
						local var_67_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_2.prefab_name].transform, "story_v_out_102092", "102092016", "story_v_out_102092.awb")

						arg_64_1:RecordAudio("102092016", var_67_7)
						arg_64_1:RecordAudio("102092016", var_67_7)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102092", "102092016", "story_v_out_102092.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102092", "102092016", "story_v_out_102092.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play102092017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102092017
		arg_68_1.duration_ = 19.4

		local var_68_0 = {
			ja = 16.733,
			ko = 18.5,
			zh = 15.933,
			en = 19.4
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play102092018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_71_0 = 0
			local var_71_1 = 1.6

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_2 = arg_68_1:GetWordFromCfg(102092017)
				local var_71_3 = arg_68_1:FormatText(var_71_2.content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 64 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 64)

				if (64 <= 0 and var_71_1 or var_71_1 * (utf8.len(var_71_3) / 64)) > 0 and var_71_1 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092017", "story_v_out_102092.awb") ~= 0 then
					local var_71_6 = manager.audio:GetVoiceLength("story_v_out_102092", "102092017", "story_v_out_102092.awb") / 1000

					if var_71_6 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_0
					end

					if var_71_2.prefab_name ~= "" and arg_68_1.actors_[var_71_2.prefab_name] ~= nil then
						local var_71_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_2.prefab_name].transform, "story_v_out_102092", "102092017", "story_v_out_102092.awb")

						arg_68_1:RecordAudio("102092017", var_71_7)
						arg_68_1:RecordAudio("102092017", var_71_7)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102092", "102092017", "story_v_out_102092.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102092", "102092017", "story_v_out_102092.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play102092018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102092018
		arg_72_1.duration_ = 7.6

		local var_72_0 = {
			ja = 7.6,
			ko = 4.9,
			zh = 4.866,
			en = 6.266
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play102092019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1011ui_story"]) and arg_72_1.var_.characterEffect1011ui_story == nil then
				arg_72_1.var_.characterEffect1011ui_story = arg_72_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1011ui_story"]) then
				if arg_72_1.var_.characterEffect1011ui_story and not isNil(arg_72_1.actors_["1011ui_story"]) then
					arg_72_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1011ui_story"]) and arg_72_1.var_.characterEffect1011ui_story then
				arg_72_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["10002ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect10002ui_story == nil then
				arg_72_1.var_.characterEffect10002ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect10002ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect10002ui_story then
				arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_75_4 = arg_72_1.actors_["1011ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1011ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_75_6 = arg_72_1.actors_["10002ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10002ui_story = var_75_6.localPosition
			end

			local var_75_7 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				var_75_6.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_72_1.time_ - 0) / var_75_7)
				var_75_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_6.position).x, (manager.ui.mainCamera.transform.position - var_75_6.position).y, (manager.ui.mainCamera.transform.position - var_75_6.position).z)
				var_75_6.localEulerAngles.z = 0
				var_75_6.localEulerAngles.x = 0
				var_75_6.localEulerAngles = var_75_6.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				var_75_6.localPosition = Vector3.New(0, -1.2, -5.8)
				var_75_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_6.position).x, (manager.ui.mainCamera.transform.position - var_75_6.position).y, (manager.ui.mainCamera.transform.position - var_75_6.position).z)
				var_75_6.localEulerAngles.z = 0
				var_75_6.localEulerAngles.x = 0
				var_75_6.localEulerAngles = var_75_6.localEulerAngles
			end

			local var_75_8 = arg_72_1.actors_["10002ui_story"].transform

			if 0.033 < arg_72_1.time_ and arg_72_1.time_ <= 0.033 + arg_75_0 then
				arg_72_1.var_.moveOldPos10002ui_story = var_75_8.localPosition
			end

			local var_75_9 = 0.5

			if 0.033 <= arg_72_1.time_ and arg_72_1.time_ < 0.033 + var_75_9 then
				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_72_1.time_ - 0.033) / var_75_9)
				var_75_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_8.position).x, (manager.ui.mainCamera.transform.position - var_75_8.position).y, (manager.ui.mainCamera.transform.position - var_75_8.position).z)
				var_75_8.localEulerAngles.z = 0
				var_75_8.localEulerAngles.x = 0
				var_75_8.localEulerAngles = var_75_8.localEulerAngles
			end

			if arg_72_1.time_ >= 0.033 + var_75_9 and arg_72_1.time_ < 0.033 + var_75_9 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_75_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_8.position).x, (manager.ui.mainCamera.transform.position - var_75_8.position).y, (manager.ui.mainCamera.transform.position - var_75_8.position).z)
				var_75_8.localEulerAngles.z = 0
				var_75_8.localEulerAngles.x = 0
				var_75_8.localEulerAngles = var_75_8.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_75_10 = 0
			local var_75_11 = 0.525

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_12 = arg_72_1:GetWordFromCfg(102092018)
				local var_75_13 = arg_72_1:FormatText(var_75_12.content)

				arg_72_1.text_.text = var_75_13

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_15 = 21 <= 0 and var_75_11 or var_75_11 * (utf8.len(var_75_13) / 21)

				if (21 <= 0 and var_75_11 or var_75_11 * (utf8.len(var_75_13) / 21)) > 0 and var_75_11 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_10 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_10
					end
				end

				arg_72_1.text_.text = var_75_13
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092018", "story_v_out_102092.awb") ~= 0 then
					local var_75_16 = manager.audio:GetVoiceLength("story_v_out_102092", "102092018", "story_v_out_102092.awb") / 1000

					if var_75_16 + var_75_10 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_10
					end

					if var_75_12.prefab_name ~= "" and arg_72_1.actors_[var_75_12.prefab_name] ~= nil then
						local var_75_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_12.prefab_name].transform, "story_v_out_102092", "102092018", "story_v_out_102092.awb")

						arg_72_1:RecordAudio("102092018", var_75_17)
						arg_72_1:RecordAudio("102092018", var_75_17)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102092", "102092018", "story_v_out_102092.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102092", "102092018", "story_v_out_102092.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_18 = math.max(var_75_11, arg_72_1.talkMaxDuration)

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_18 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_10) / var_75_18

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_10 + var_75_18 and arg_72_1.time_ < var_75_10 + var_75_18 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play102092019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102092019
		arg_76_1.duration_ = 11.67

		local var_76_0 = {
			ja = 11.666,
			ko = 6.933,
			zh = 6.933,
			en = 6.5
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play102092020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) and arg_76_1.var_.characterEffect10002ui_story == nil then
				arg_76_1.var_.characterEffect10002ui_story = arg_76_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) then
				if arg_76_1.var_.characterEffect10002ui_story and not isNil(arg_76_1.actors_["10002ui_story"]) then
					arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) and arg_76_1.var_.characterEffect10002ui_story then
				arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1011ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1011ui_story == nil then
				arg_76_1.var_.characterEffect1011ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1011ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1011ui_story then
				arg_76_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action2_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.625

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(102092019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 25 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 25)

				if (25 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 25)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092019", "story_v_out_102092.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092019", "story_v_out_102092.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_102092", "102092019", "story_v_out_102092.awb")

						arg_76_1:RecordAudio("102092019", var_79_11)
						arg_76_1:RecordAudio("102092019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_102092", "102092019", "story_v_out_102092.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_102092", "102092019", "story_v_out_102092.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play102092020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102092020
		arg_80_1.duration_ = 20.23

		local var_80_0 = {
			ja = 12.6,
			ko = 20.233,
			zh = 15.4,
			en = 17.7
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play102092021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_83_0 = 0
			local var_83_1 = 1.625

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(102092020)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 65 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 65)

				if (65 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 65)) > 0 and var_83_1 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092020", "story_v_out_102092.awb") ~= 0 then
					local var_83_6 = manager.audio:GetVoiceLength("story_v_out_102092", "102092020", "story_v_out_102092.awb") / 1000

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end

					if var_83_2.prefab_name ~= "" and arg_80_1.actors_[var_83_2.prefab_name] ~= nil then
						local var_83_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_2.prefab_name].transform, "story_v_out_102092", "102092020", "story_v_out_102092.awb")

						arg_80_1:RecordAudio("102092020", var_83_7)
						arg_80_1:RecordAudio("102092020", var_83_7)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102092", "102092020", "story_v_out_102092.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102092", "102092020", "story_v_out_102092.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play102092021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102092021
		arg_84_1.duration_ = 4.2

		local var_84_0 = {
			ja = 4.2,
			ko = 1.9,
			zh = 1.1,
			en = 1.7
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102092022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = arg_84_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) then
				if arg_84_1.var_.characterEffect1084ui_story and not isNil(arg_84_1.actors_["1084ui_story"]) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["10002ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect10002ui_story == nil then
				arg_84_1.var_.characterEffect10002ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect10002ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect10002ui_story then
				arg_84_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_87_4 = 0
			local var_87_5 = 0.15

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_6 = arg_84_1:GetWordFromCfg(102092021)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 6 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 6)

				if (6 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 6)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092021", "story_v_out_102092.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092021", "story_v_out_102092.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_102092", "102092021", "story_v_out_102092.awb")

						arg_84_1:RecordAudio("102092021", var_87_11)
						arg_84_1:RecordAudio("102092021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_102092", "102092021", "story_v_out_102092.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_102092", "102092021", "story_v_out_102092.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play102092022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102092022
		arg_88_1.duration_ = 12.93

		local var_88_0 = {
			ja = 9.533,
			ko = 6.133,
			zh = 6.2,
			en = 12.933
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play102092023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1011ui_story"]) and arg_88_1.var_.characterEffect1011ui_story == nil then
				arg_88_1.var_.characterEffect1011ui_story = arg_88_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1011ui_story"]) then
				if arg_88_1.var_.characterEffect1011ui_story and not isNil(arg_88_1.actors_["1011ui_story"]) then
					arg_88_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1011ui_story"]) and arg_88_1.var_.characterEffect1011ui_story then
				arg_88_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["1084ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_91_4 = 0
			local var_91_5 = 0.75

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(102092022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 30 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 30)

				if (30 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 30)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092022", "story_v_out_102092.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092022", "story_v_out_102092.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_102092", "102092022", "story_v_out_102092.awb")

						arg_88_1:RecordAudio("102092022", var_91_11)
						arg_88_1:RecordAudio("102092022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102092", "102092022", "story_v_out_102092.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102092", "102092022", "story_v_out_102092.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play102092023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102092023
		arg_92_1.duration_ = 7.93

		local var_92_0 = {
			ja = 7.9,
			ko = 7.266,
			zh = 6.6,
			en = 7.933
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play102092024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1011ui_story"]) and arg_92_1.var_.characterEffect1011ui_story == nil then
				arg_92_1.var_.characterEffect1011ui_story = arg_92_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1011ui_story"]) then
				if arg_92_1.var_.characterEffect1011ui_story and not isNil(arg_92_1.actors_["1011ui_story"]) then
					arg_92_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1011ui_story"]) and arg_92_1.var_.characterEffect1011ui_story then
				arg_92_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_95_1 = arg_92_1.actors_["1011ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1011ui_story = var_95_1.localPosition
			end

			local var_95_2 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 then
				var_95_1.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_2)
				var_95_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_1.position).x, (manager.ui.mainCamera.transform.position - var_95_1.position).y, (manager.ui.mainCamera.transform.position - var_95_1.position).z)
				var_95_1.localEulerAngles.z = 0
				var_95_1.localEulerAngles.x = 0
				var_95_1.localEulerAngles = var_95_1.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 then
				var_95_1.localPosition = Vector3.New(0, 100, 0)
				var_95_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_1.position).x, (manager.ui.mainCamera.transform.position - var_95_1.position).y, (manager.ui.mainCamera.transform.position - var_95_1.position).z)
				var_95_1.localEulerAngles.z = 0
				var_95_1.localEulerAngles.x = 0
				var_95_1.localEulerAngles = var_95_1.localEulerAngles
			end

			local var_95_3 = arg_92_1.actors_["10002ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10002ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			local var_95_5 = arg_92_1.actors_["10002ui_story"].transform

			if 0.033 < arg_92_1.time_ and arg_92_1.time_ <= 0.033 + arg_95_0 then
				arg_92_1.var_.moveOldPos10002ui_story = var_95_5.localPosition
			end

			local var_95_6 = 0.5

			if 0.033 <= arg_92_1.time_ and arg_92_1.time_ < 0.033 + var_95_6 then
				var_95_5.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_92_1.time_ - 0.033) / var_95_6)
				var_95_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_5.position).x, (manager.ui.mainCamera.transform.position - var_95_5.position).y, (manager.ui.mainCamera.transform.position - var_95_5.position).z)
				var_95_5.localEulerAngles.z = 0
				var_95_5.localEulerAngles.x = 0
				var_95_5.localEulerAngles = var_95_5.localEulerAngles
			end

			if arg_92_1.time_ >= 0.033 + var_95_6 and arg_92_1.time_ < 0.033 + var_95_6 + arg_95_0 then
				var_95_5.localPosition = Vector3.New(0, -1.2, -5.8)
				var_95_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_5.position).x, (manager.ui.mainCamera.transform.position - var_95_5.position).y, (manager.ui.mainCamera.transform.position - var_95_5.position).z)
				var_95_5.localEulerAngles.z = 0
				var_95_5.localEulerAngles.x = 0
				var_95_5.localEulerAngles = var_95_5.localEulerAngles
			end

			local var_95_7 = 0
			local var_95_8 = 0.85

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(102092023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_12 = 34 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 34)

				if (34 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 34)) > 0 and var_95_8 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092023", "story_v_out_102092.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_102092", "102092023", "story_v_out_102092.awb") / 1000

					if var_95_13 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_7
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_102092", "102092023", "story_v_out_102092.awb")

						arg_92_1:RecordAudio("102092023", var_95_14)
						arg_92_1:RecordAudio("102092023", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102092", "102092023", "story_v_out_102092.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102092", "102092023", "story_v_out_102092.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_15 and arg_92_1.time_ < var_95_7 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play102092024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102092024
		arg_96_1.duration_ = 19.27

		local var_96_0 = {
			ja = 11.433,
			ko = 19.266,
			zh = 19.266,
			en = 19.266
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play102092025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10002ui_story"]) and arg_96_1.var_.characterEffect10002ui_story == nil then
				arg_96_1.var_.characterEffect10002ui_story = arg_96_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10002ui_story"]) then
				if arg_96_1.var_.characterEffect10002ui_story and not isNil(arg_96_1.actors_["10002ui_story"]) then
					arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10002ui_story"]) and arg_96_1.var_.characterEffect10002ui_story then
				arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action423")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_99_2 = 0
			local var_99_3 = 2.075

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(102092024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 83 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 83)

				if (83 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 83)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092024", "story_v_out_102092.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_102092", "102092024", "story_v_out_102092.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_102092", "102092024", "story_v_out_102092.awb")

						arg_96_1:RecordAudio("102092024", var_99_9)
						arg_96_1:RecordAudio("102092024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102092", "102092024", "story_v_out_102092.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102092", "102092024", "story_v_out_102092.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play102092025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102092025
		arg_100_1.duration_ = 11.97

		local var_100_0 = {
			ja = 11.966,
			ko = 7.033,
			zh = 6.433,
			en = 9.033
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play102092026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_103_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_100_1.stage_.transform)

				var_103_0.name = "1019ui_story"
				var_103_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["1019ui_story"] = var_103_0

				local var_103_1 = var_103_0:GetComponentInChildren(typeof(CharacterEffect))

				var_103_1.enabled = true

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end

				arg_100_1:ShowWeapon(var_103_1.transform, false)

				arg_100_1.var_["1019ui_story" .. "Animator"] = var_103_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_100_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_100_1.var_["1019ui_story" .. "LipSync"] = var_103_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_103_3 = 0
			local var_103_4 = 0.675

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(102092025)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_8 = 27 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_6) / 27)

				if (27 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_6) / 27)) > 0 and var_103_4 < var_103_8 then
					arg_100_1.talkMaxDuration = var_103_8

					if var_103_8 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092025", "story_v_out_102092.awb") ~= 0 then
					local var_103_9 = manager.audio:GetVoiceLength("story_v_out_102092", "102092025", "story_v_out_102092.awb") / 1000

					if var_103_9 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_3
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_102092", "102092025", "story_v_out_102092.awb")

						arg_100_1:RecordAudio("102092025", var_103_10)
						arg_100_1:RecordAudio("102092025", var_103_10)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102092", "102092025", "story_v_out_102092.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102092", "102092025", "story_v_out_102092.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_11 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_11 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_11

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_11 and arg_100_1.time_ < var_103_3 + var_103_11 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play102092026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102092026
		arg_104_1.duration_ = 3.6

		local var_104_0 = {
			ja = 3.6,
			ko = 2.933,
			zh = 2.7,
			en = 3.233
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play102092027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1019ui_story"]) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = arg_104_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1019ui_story"]) then
				if arg_104_1.var_.characterEffect1019ui_story and not isNil(arg_104_1.actors_["1019ui_story"]) then
					arg_104_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1019ui_story"]) and arg_104_1.var_.characterEffect1019ui_story then
				arg_104_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["10002ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect10002ui_story == nil then
				arg_104_1.var_.characterEffect10002ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect10002ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect10002ui_story then
				arg_104_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_107_4 = arg_104_1.actors_["10002ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10002ui_story = var_107_4.localPosition
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_104_1.time_ - 0) / var_107_5)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(0, -1.2, -5.8)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			local var_107_6 = arg_104_1.actors_["10002ui_story"].transform

			if 0.033 < arg_104_1.time_ and arg_104_1.time_ <= 0.033 + arg_107_0 then
				arg_104_1.var_.moveOldPos10002ui_story = var_107_6.localPosition
			end

			local var_107_7 = 0.5

			if 0.033 <= arg_104_1.time_ and arg_104_1.time_ < 0.033 + var_107_7 then
				var_107_6.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_104_1.time_ - 0.033) / var_107_7)
				var_107_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_6.position).x, (manager.ui.mainCamera.transform.position - var_107_6.position).y, (manager.ui.mainCamera.transform.position - var_107_6.position).z)
				var_107_6.localEulerAngles.z = 0
				var_107_6.localEulerAngles.x = 0
				var_107_6.localEulerAngles = var_107_6.localEulerAngles
			end

			if arg_104_1.time_ >= 0.033 + var_107_7 and arg_104_1.time_ < 0.033 + var_107_7 + arg_107_0 then
				var_107_6.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_107_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_6.position).x, (manager.ui.mainCamera.transform.position - var_107_6.position).y, (manager.ui.mainCamera.transform.position - var_107_6.position).z)
				var_107_6.localEulerAngles.z = 0
				var_107_6.localEulerAngles.x = 0
				var_107_6.localEulerAngles = var_107_6.localEulerAngles
			end

			local var_107_8 = arg_104_1.actors_["1019ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1019ui_story = var_107_8.localPosition
			end

			local var_107_9 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_9 then
				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_104_1.time_ - 0) / var_107_9)
				var_107_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_8.position).x, (manager.ui.mainCamera.transform.position - var_107_8.position).y, (manager.ui.mainCamera.transform.position - var_107_8.position).z)
				var_107_8.localEulerAngles.z = 0
				var_107_8.localEulerAngles.x = 0
				var_107_8.localEulerAngles = var_107_8.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_9 and arg_104_1.time_ < 0 + var_107_9 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_107_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_8.position).x, (manager.ui.mainCamera.transform.position - var_107_8.position).y, (manager.ui.mainCamera.transform.position - var_107_8.position).z)
				var_107_8.localEulerAngles.z = 0
				var_107_8.localEulerAngles.x = 0
				var_107_8.localEulerAngles = var_107_8.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_107_10 = 0
			local var_107_11 = 0.325

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_12 = arg_104_1:GetWordFromCfg(102092026)
				local var_107_13 = arg_104_1:FormatText(var_107_12.content)

				arg_104_1.text_.text = var_107_13

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_15 = 13 <= 0 and var_107_11 or var_107_11 * (utf8.len(var_107_13) / 13)

				if (13 <= 0 and var_107_11 or var_107_11 * (utf8.len(var_107_13) / 13)) > 0 and var_107_11 < var_107_15 then
					arg_104_1.talkMaxDuration = var_107_15

					if var_107_15 + var_107_10 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_10
					end
				end

				arg_104_1.text_.text = var_107_13
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092026", "story_v_out_102092.awb") ~= 0 then
					local var_107_16 = manager.audio:GetVoiceLength("story_v_out_102092", "102092026", "story_v_out_102092.awb") / 1000

					if var_107_16 + var_107_10 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_10
					end

					if var_107_12.prefab_name ~= "" and arg_104_1.actors_[var_107_12.prefab_name] ~= nil then
						local var_107_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_12.prefab_name].transform, "story_v_out_102092", "102092026", "story_v_out_102092.awb")

						arg_104_1:RecordAudio("102092026", var_107_17)
						arg_104_1:RecordAudio("102092026", var_107_17)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102092", "102092026", "story_v_out_102092.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102092", "102092026", "story_v_out_102092.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_18 = math.max(var_107_11, arg_104_1.talkMaxDuration)

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_18 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_10) / var_107_18

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_10 + var_107_18 and arg_104_1.time_ < var_107_10 + var_107_18 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play102092027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102092027
		arg_108_1.duration_ = 14.83

		local var_108_0 = {
			ja = 14.833,
			ko = 10.333,
			zh = 11,
			en = 11.1
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play102092028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10002ui_story"]) and arg_108_1.var_.characterEffect10002ui_story == nil then
				arg_108_1.var_.characterEffect10002ui_story = arg_108_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10002ui_story"]) then
				if arg_108_1.var_.characterEffect10002ui_story and not isNil(arg_108_1.actors_["10002ui_story"]) then
					arg_108_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10002ui_story"]) and arg_108_1.var_.characterEffect10002ui_story then
				arg_108_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["1019ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect1019ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1019ui_story then
				arg_108_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002actionlink/10002action432")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_111_4 = 0
			local var_111_5 = 0.925

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(102092027)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 37 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 37)

				if (37 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 37)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092027", "story_v_out_102092.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092027", "story_v_out_102092.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_102092", "102092027", "story_v_out_102092.awb")

						arg_108_1:RecordAudio("102092027", var_111_11)
						arg_108_1:RecordAudio("102092027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102092", "102092027", "story_v_out_102092.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102092", "102092027", "story_v_out_102092.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play102092028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102092028
		arg_112_1.duration_ = 2

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
			arg_112_1.auto_ = false
		end

		function arg_112_1.playNext_(arg_114_0)
			arg_112_1.onStoryFinished_()
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1019ui_story"]) and arg_112_1.var_.characterEffect1019ui_story == nil then
				arg_112_1.var_.characterEffect1019ui_story = arg_112_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1019ui_story"]) then
				if arg_112_1.var_.characterEffect1019ui_story and not isNil(arg_112_1.actors_["1019ui_story"]) then
					arg_112_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1019ui_story"]) and arg_112_1.var_.characterEffect1019ui_story then
				arg_112_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["10002ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect10002ui_story == nil then
				arg_112_1.var_.characterEffect10002ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect10002ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect10002ui_story then
				arg_112_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_115_4 = 0
			local var_115_5 = 0.125

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(102092028)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 5 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 5)

				if (5 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 5)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102092", "102092028", "story_v_out_102092.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_102092", "102092028", "story_v_out_102092.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_102092", "102092028", "story_v_out_102092.awb")

						arg_112_1:RecordAudio("102092028", var_115_11)
						arg_112_1:RecordAudio("102092028", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102092", "102092028", "story_v_out_102092.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102092", "102092028", "story_v_out_102092.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02c"
	},
	voices = {
		"story_v_out_102092.awb"
	}
}
