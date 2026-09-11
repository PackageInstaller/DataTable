return {
	Play317211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_4_0.name = "K09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K09f

				arg_1_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.733333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.733333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.85

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317211001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)

				if (34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317211002
		arg_9_1.duration_ = 6.03

		local var_9_0 = {
			zh = 6.033,
			ja = 4.9
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1199ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1199ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1199ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1199ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1199ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1199ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1199ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1199ui_story == nil then
				arg_9_1.var_.characterEffect1199ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1199ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1199ui_story then
				arg_9_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.875

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(317211002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 35 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 35)

				if (35 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 35)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211002", "story_v_out_317211.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211002", "story_v_out_317211.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_317211", "317211002", "story_v_out_317211.awb")

						arg_9_1:RecordAudio("317211002", var_12_15)
						arg_9_1:RecordAudio("317211002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_317211", "317211002", "story_v_out_317211.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_317211", "317211002", "story_v_out_317211.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play317211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317211003
		arg_13_1.duration_ = 2.33

		local var_13_0 = {
			zh = 1,
			ja = 2.333
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1093ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1093ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1093ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1093ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1093ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1093ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1093ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1093ui_story == nil then
				arg_13_1.var_.characterEffect1093ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1093ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1093ui_story then
				arg_13_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = arg_13_1.actors_["1199ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.characterEffect1199ui_story == nil then
				arg_13_1.var_.characterEffect1199ui_story = var_16_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_9 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.characterEffect1199ui_story and not isNil(var_16_8) then
					arg_13_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_9)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.characterEffect1199ui_story then
				arg_13_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_16_10 = 0
			local var_16_11 = 0.1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(317211003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 4 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 4)

				if (4 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 4)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211003", "story_v_out_317211.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_317211", "317211003", "story_v_out_317211.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_317211", "317211003", "story_v_out_317211.awb")

						arg_13_1:RecordAudio("317211003", var_16_17)
						arg_13_1:RecordAudio("317211003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317211", "317211003", "story_v_out_317211.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317211", "317211003", "story_v_out_317211.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play317211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317211004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1199ui_story = arg_17_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).z)
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles = arg_17_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1199ui_story"].transform.position).z)
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1199ui_story"].transform.localEulerAngles = arg_17_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1093ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1093ui_story = var_20_1.localPosition
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 then
				var_20_1.localPosition = Vector3.New(0, 100, 0)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			local var_20_3 = 0
			local var_20_4 = 1.025

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(317211004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 41 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 41)

				if (41 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 41)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play317211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317211005
		arg_21_1.duration_ = 2.77

		local var_21_0 = {
			zh = 2.066,
			ja = 2.766
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1199ui_story = arg_21_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).z)
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles = arg_21_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_21_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1199ui_story"].transform.position).z)
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1199ui_story"].transform.localEulerAngles = arg_21_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1199ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1199ui_story == nil then
				arg_21_1.var_.characterEffect1199ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1199ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1199ui_story then
				arg_21_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(317211005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 7 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 7)

				if (7 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 7)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211005", "story_v_out_317211.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211005", "story_v_out_317211.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_317211", "317211005", "story_v_out_317211.awb")

						arg_21_1:RecordAudio("317211005", var_24_11)
						arg_21_1:RecordAudio("317211005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317211", "317211005", "story_v_out_317211.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317211", "317211005", "story_v_out_317211.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317211006
		arg_25_1.duration_ = 6.7

		local var_25_0 = {
			zh = 5.733,
			ja = 6.7
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = arg_25_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).z)
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles = arg_25_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_25_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).z)
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles = arg_25_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1093ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = arg_25_1.actors_["1199ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1199ui_story == nil then
				arg_25_1.var_.characterEffect1199ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect1199ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1199ui_story then
				arg_25_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(317211006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 17 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 17)

				if (17 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 17)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211006", "story_v_out_317211.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211006", "story_v_out_317211.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_317211", "317211006", "story_v_out_317211.awb")

						arg_25_1:RecordAudio("317211006", var_28_13)
						arg_25_1:RecordAudio("317211006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317211", "317211006", "story_v_out_317211.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317211", "317211006", "story_v_out_317211.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play317211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317211007
		arg_29_1.duration_ = 5.6

		local var_29_0 = {
			zh = 2.166,
			ja = 5.6
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play317211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1199ui_story = arg_29_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).z)
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles = arg_29_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_29_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1199ui_story"].transform.position).z)
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1199ui_story"].transform.localEulerAngles = arg_29_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1199ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1199ui_story == nil then
				arg_29_1.var_.characterEffect1199ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1199ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1199ui_story then
				arg_29_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_4 = arg_29_1.actors_["1093ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1093ui_story = var_32_4.localPosition
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_4.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_29_1.time_ - 0) / var_32_5)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_4.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_32_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_4.position).x, (manager.ui.mainCamera.transform.position - var_32_4.position).y, (manager.ui.mainCamera.transform.position - var_32_4.position).z)
				var_32_4.localEulerAngles.z = 0
				var_32_4.localEulerAngles.x = 0
				var_32_4.localEulerAngles = var_32_4.localEulerAngles
			end

			local var_32_6 = arg_29_1.actors_["1093ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1093ui_story == nil then
				arg_29_1.var_.characterEffect1093ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_7 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 and not isNil(var_32_6) then
				if arg_29_1.var_.characterEffect1093ui_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_7)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect1093ui_story then
				arg_29_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_32_8 = 0
			local var_32_9 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(317211007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 13 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 13)

				if (13 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 13)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211007", "story_v_out_317211.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211007", "story_v_out_317211.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_317211", "317211007", "story_v_out_317211.awb")

						arg_29_1:RecordAudio("317211007", var_32_15)
						arg_29_1:RecordAudio("317211007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317211", "317211007", "story_v_out_317211.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317211", "317211007", "story_v_out_317211.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play317211008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317211008
		arg_33_1.duration_ = 12.2

		local var_33_0 = {
			zh = 8.3,
			ja = 12.2
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317211009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1015ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1015ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1015ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1015ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1015ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1015ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1015ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1015ui_story == nil then
				arg_33_1.var_.characterEffect1015ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1015ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1015ui_story then
				arg_33_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_8 = arg_33_1.actors_["1093ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1093ui_story = var_36_8.localPosition
			end

			local var_36_9 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 then
				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_33_1.time_ - 0) / var_36_9)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			local var_36_10 = arg_33_1.actors_["1093ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = var_36_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 and not isNil(var_36_10) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(var_36_10) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_11)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_36_12 = arg_33_1.actors_["1199ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1199ui_story = var_36_12.localPosition
			end

			local var_36_13 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_13 then
				var_36_12.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_13)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_13 and arg_33_1.time_ < 0 + var_36_13 + arg_36_0 then
				var_36_12.localPosition = Vector3.New(0, 100, 0)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			local var_36_14 = 0
			local var_36_15 = 0.9

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_16 = arg_33_1:GetWordFromCfg(317211008)
				local var_36_17 = arg_33_1:FormatText(var_36_16.content)

				arg_33_1.text_.text = var_36_17

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 36 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 36)

				if (36 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 36)) > 0 and var_36_15 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19

					if var_36_19 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_17
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211008", "story_v_out_317211.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_317211", "317211008", "story_v_out_317211.awb") / 1000

					if var_36_20 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_14
					end

					if var_36_16.prefab_name ~= "" and arg_33_1.actors_[var_36_16.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_16.prefab_name].transform, "story_v_out_317211", "317211008", "story_v_out_317211.awb")

						arg_33_1:RecordAudio("317211008", var_36_21)
						arg_33_1:RecordAudio("317211008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317211", "317211008", "story_v_out_317211.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317211", "317211008", "story_v_out_317211.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_22 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_22 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_22

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_22 and arg_33_1.time_ < var_36_14 + var_36_22 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play317211009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317211009
		arg_37_1.duration_ = 14.87

		local var_37_0 = {
			zh = 8.733,
			ja = 14.866
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play317211010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1093ui_story = arg_37_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).z)
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles = arg_37_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_37_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).z)
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles = arg_37_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1093ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action464")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = arg_37_1.actors_["1015ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1015ui_story == nil then
				arg_37_1.var_.characterEffect1015ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect1015ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1015ui_story then
				arg_37_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_40_6 = 0
			local var_40_7 = 0.9

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(317211009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 36 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 36)

				if (36 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 36)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211009", "story_v_out_317211.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211009", "story_v_out_317211.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_317211", "317211009", "story_v_out_317211.awb")

						arg_37_1:RecordAudio("317211009", var_40_13)
						arg_37_1:RecordAudio("317211009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317211", "317211009", "story_v_out_317211.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317211", "317211009", "story_v_out_317211.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play317211010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317211010
		arg_41_1.duration_ = 8.8

		local var_41_0 = {
			zh = 8.8,
			ja = 7.2
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317211011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1015ui_story = arg_41_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).z)
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles = arg_41_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_41_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1015ui_story"].transform.position).z)
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1015ui_story"].transform.localEulerAngles = arg_41_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1015ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1015ui_story == nil then
				arg_41_1.var_.characterEffect1015ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1015ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1015ui_story then
				arg_41_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["1093ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1093ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 0.95

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(317211010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 38 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 38)

				if (38 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 38)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211010", "story_v_out_317211.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211010", "story_v_out_317211.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_317211", "317211010", "story_v_out_317211.awb")

						arg_41_1:RecordAudio("317211010", var_44_13)
						arg_41_1:RecordAudio("317211010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317211", "317211010", "story_v_out_317211.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317211", "317211010", "story_v_out_317211.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play317211011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317211011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317211012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1015ui_story = arg_45_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1015ui_story"].transform.position).z)
				arg_45_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1015ui_story"].transform.localEulerAngles = arg_45_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1015ui_story"].transform.position).z)
				arg_45_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1015ui_story"].transform.localEulerAngles = arg_45_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1093ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1093ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = 0
			local var_48_4 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(317211011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 28 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 28)

				if (28 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 28)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play317211012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317211012
		arg_49_1.duration_ = 4.4

		local var_49_0 = {
			zh = 2.233,
			ja = 4.4
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play317211013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1199ui_story = arg_49_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1199ui_story"].transform.position).z)
				arg_49_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1199ui_story"].transform.localEulerAngles = arg_49_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_49_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1199ui_story"].transform.position).z)
				arg_49_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1199ui_story"].transform.localEulerAngles = arg_49_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1199ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1199ui_story == nil then
				arg_49_1.var_.characterEffect1199ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1199ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1199ui_story then
				arg_49_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(317211012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 12 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 12)

				if (12 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 12)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211012", "story_v_out_317211.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211012", "story_v_out_317211.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_317211", "317211012", "story_v_out_317211.awb")

						arg_49_1:RecordAudio("317211012", var_52_11)
						arg_49_1:RecordAudio("317211012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317211", "317211012", "story_v_out_317211.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317211", "317211012", "story_v_out_317211.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play317211013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317211013
		arg_53_1.duration_ = 8.9

		local var_53_0 = {
			zh = 4.3,
			ja = 8.9
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317211014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1015ui_story = arg_53_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1015ui_story"].transform.position).z)
				arg_53_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1015ui_story"].transform.localEulerAngles = arg_53_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0.7, -1.15, -6.2)
				arg_53_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1015ui_story"].transform.position).z)
				arg_53_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1015ui_story"].transform.localEulerAngles = arg_53_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1015ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1015ui_story == nil then
				arg_53_1.var_.characterEffect1015ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1015ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1015ui_story then
				arg_53_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = arg_53_1.actors_["1199ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1199ui_story == nil then
				arg_53_1.var_.characterEffect1199ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect1199ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect1199ui_story then
				arg_53_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_56_6 = 0
			local var_56_7 = 0.575

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(317211013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 23 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 23)

				if (23 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 23)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211013", "story_v_out_317211.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211013", "story_v_out_317211.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_317211", "317211013", "story_v_out_317211.awb")

						arg_53_1:RecordAudio("317211013", var_56_13)
						arg_53_1:RecordAudio("317211013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_317211", "317211013", "story_v_out_317211.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_317211", "317211013", "story_v_out_317211.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play317211014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317211014
		arg_57_1.duration_ = 5.23

		local var_57_0 = {
			zh = 3.433,
			ja = 5.233
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play317211015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1199ui_story = arg_57_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).z)
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles = arg_57_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_57_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1199ui_story"].transform.position).z)
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1199ui_story"].transform.localEulerAngles = arg_57_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1199ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1199ui_story == nil then
				arg_57_1.var_.characterEffect1199ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1199ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1199ui_story then
				arg_57_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_60_4 = arg_57_1.actors_["1015ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1015ui_story == nil then
				arg_57_1.var_.characterEffect1015ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect1015ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1015ui_story then
				arg_57_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_60_6 = 0
			local var_60_7 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(317211014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 16 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 16)

				if (16 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 16)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211014", "story_v_out_317211.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211014", "story_v_out_317211.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_317211", "317211014", "story_v_out_317211.awb")

						arg_57_1:RecordAudio("317211014", var_60_13)
						arg_57_1:RecordAudio("317211014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317211", "317211014", "story_v_out_317211.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317211", "317211014", "story_v_out_317211.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play317211015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317211015
		arg_61_1.duration_ = 7.5

		local var_61_0 = {
			zh = 3.566,
			ja = 7.5
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317211016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1015ui_story = arg_61_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1015ui_story"].transform.position).z)
				arg_61_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1015ui_story"].transform.localEulerAngles = arg_61_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1015ui_story"].transform.position).z)
				arg_61_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1015ui_story"].transform.localEulerAngles = arg_61_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1199ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1199ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 100, 0)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = arg_61_1.actors_["1093ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1093ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["1093ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1093ui_story == nil then
				arg_61_1.var_.characterEffect1093ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect1093ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect1093ui_story then
				arg_61_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_8 = 0
			local var_64_9 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(317211015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 17 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 17)

				if (17 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 17)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211015", "story_v_out_317211.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211015", "story_v_out_317211.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_317211", "317211015", "story_v_out_317211.awb")

						arg_61_1:RecordAudio("317211015", var_64_15)
						arg_61_1:RecordAudio("317211015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317211", "317211015", "story_v_out_317211.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317211", "317211015", "story_v_out_317211.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play317211016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317211016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317211017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1093ui_story = arg_65_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).z)
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles = arg_65_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1093ui_story"].transform.position).z)
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1093ui_story"].transform.localEulerAngles = arg_65_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1199ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1199ui_story = var_68_1.localPosition
			end

			local var_68_2 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 then
				var_68_1.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_65_1.time_ - 0) / var_68_2)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 then
				var_68_1.localPosition = Vector3.New(0, -1.08, -5.9)
				var_68_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_1.position).x, (manager.ui.mainCamera.transform.position - var_68_1.position).y, (manager.ui.mainCamera.transform.position - var_68_1.position).z)
				var_68_1.localEulerAngles.z = 0
				var_68_1.localEulerAngles.x = 0
				var_68_1.localEulerAngles = var_68_1.localEulerAngles
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_68_3 = arg_65_1.actors_["1199ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect1199ui_story == nil then
				arg_65_1.var_.characterEffect1199ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.0166666666666667

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect1199ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_4)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect1199ui_story then
				arg_65_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_68_5 = 0
			local var_68_6 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(317211016).content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 14 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 14)

				if (14 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 14)) > 0 and var_68_6 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_10 and arg_65_1.time_ < var_68_5 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play317211017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317211017
		arg_69_1.duration_ = 8.9

		local var_69_0 = {
			zh = 8.9,
			ja = 7.633
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317211018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1015ui_story = arg_69_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1015ui_story"].transform.position).z)
				arg_69_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1015ui_story"].transform.localEulerAngles = arg_69_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_69_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1015ui_story"].transform.position).z)
				arg_69_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1015ui_story"].transform.localEulerAngles = arg_69_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1015ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1015ui_story == nil then
				arg_69_1.var_.characterEffect1015ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1015ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1015ui_story then
				arg_69_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = arg_69_1.actors_["1199ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1199ui_story = var_72_4.localPosition
			end

			local var_72_5 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 then
				var_72_4.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_69_1.time_ - 0) / var_72_5)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 then
				var_72_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_72_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_4.position).x, (manager.ui.mainCamera.transform.position - var_72_4.position).y, (manager.ui.mainCamera.transform.position - var_72_4.position).z)
				var_72_4.localEulerAngles.z = 0
				var_72_4.localEulerAngles.x = 0
				var_72_4.localEulerAngles = var_72_4.localEulerAngles
			end

			local var_72_6 = 0
			local var_72_7 = 1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(317211017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 40 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 40)

				if (40 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 40)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211017", "story_v_out_317211.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211017", "story_v_out_317211.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_317211", "317211017", "story_v_out_317211.awb")

						arg_69_1:RecordAudio("317211017", var_72_13)
						arg_69_1:RecordAudio("317211017", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_317211", "317211017", "story_v_out_317211.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_317211", "317211017", "story_v_out_317211.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play317211018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317211018
		arg_73_1.duration_ = 8.97

		local var_73_0 = {
			zh = 8.966,
			ja = 7.066
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317211019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1199ui_story = arg_73_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1199ui_story"].transform.position).z)
				arg_73_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1199ui_story"].transform.localEulerAngles = arg_73_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_73_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1199ui_story"].transform.position).z)
				arg_73_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1199ui_story"].transform.localEulerAngles = arg_73_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1199ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1199ui_story == nil then
				arg_73_1.var_.characterEffect1199ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1199ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1199ui_story then
				arg_73_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_4 = arg_73_1.actors_["1015ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1015ui_story == nil then
				arg_73_1.var_.characterEffect1015ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect1015ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1015ui_story then
				arg_73_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_76_6 = 0
			local var_76_7 = 1.1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(317211018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 44 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 44)

				if (44 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 44)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211018", "story_v_out_317211.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211018", "story_v_out_317211.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_317211", "317211018", "story_v_out_317211.awb")

						arg_73_1:RecordAudio("317211018", var_76_13)
						arg_73_1:RecordAudio("317211018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317211", "317211018", "story_v_out_317211.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317211", "317211018", "story_v_out_317211.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play317211019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317211019
		arg_77_1.duration_ = 5.77

		local var_77_0 = {
			zh = 5.3,
			ja = 5.766
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play317211020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1015ui_story = arg_77_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).z)
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles = arg_77_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_77_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).z)
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles = arg_77_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1015ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1015ui_story == nil then
				arg_77_1.var_.characterEffect1015ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1015ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1015ui_story then
				arg_77_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = arg_77_1.actors_["1199ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1199ui_story == nil then
				arg_77_1.var_.characterEffect1199ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_5 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 and not isNil(var_80_4) then
				if arg_77_1.var_.characterEffect1199ui_story and not isNil(var_80_4) then
					arg_77_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_5)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1199ui_story then
				arg_77_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_80_6 = 0
			local var_80_7 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(317211019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 20 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 20)

				if (20 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 20)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211019", "story_v_out_317211.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211019", "story_v_out_317211.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_317211", "317211019", "story_v_out_317211.awb")

						arg_77_1:RecordAudio("317211019", var_80_13)
						arg_77_1:RecordAudio("317211019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317211", "317211019", "story_v_out_317211.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317211", "317211019", "story_v_out_317211.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play317211020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317211020
		arg_81_1.duration_ = 6.5

		local var_81_0 = {
			zh = 6.5,
			ja = 6.066
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317211021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1015ui_story = arg_81_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1015ui_story"].transform.position).z)
				arg_81_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1015ui_story"].transform.localEulerAngles = arg_81_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1015ui_story"].transform.position).z)
				arg_81_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1015ui_story"].transform.localEulerAngles = arg_81_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1199ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1199ui_story = var_84_1.localPosition
			end

			local var_84_2 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 then
				var_84_1.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_81_1.time_ - 0) / var_84_2)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 then
				var_84_1.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			local var_84_3 = arg_81_1.actors_["1199ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1199ui_story == nil then
				arg_81_1.var_.characterEffect1199ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.0166666666666667

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect1199ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_4)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect1199ui_story then
				arg_81_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_84_5 = arg_81_1.actors_["1093ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1093ui_story = var_84_5.localPosition
			end

			local var_84_6 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_81_1.time_ - 0) / var_84_6)
				var_84_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_5.position).x, (manager.ui.mainCamera.transform.position - var_84_5.position).y, (manager.ui.mainCamera.transform.position - var_84_5.position).z)
				var_84_5.localEulerAngles.z = 0
				var_84_5.localEulerAngles.x = 0
				var_84_5.localEulerAngles = var_84_5.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_84_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_5.position).x, (manager.ui.mainCamera.transform.position - var_84_5.position).y, (manager.ui.mainCamera.transform.position - var_84_5.position).z)
				var_84_5.localEulerAngles.z = 0
				var_84_5.localEulerAngles.x = 0
				var_84_5.localEulerAngles = var_84_5.localEulerAngles
			end

			local var_84_7 = arg_81_1.actors_["1093ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = var_84_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_8 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_8 and not isNil(var_84_7) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(var_84_7) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_8 and arg_81_1.time_ < 0 + var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_10 = 0
			local var_84_11 = 0.675

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_12 = arg_81_1:GetWordFromCfg(317211020)
				local var_84_13 = arg_81_1:FormatText(var_84_12.content)

				arg_81_1.text_.text = var_84_13

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 27 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 27)

				if (27 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 27)) > 0 and var_84_11 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_13
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211020", "story_v_out_317211.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_317211", "317211020", "story_v_out_317211.awb") / 1000

					if var_84_16 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_10
					end

					if var_84_12.prefab_name ~= "" and arg_81_1.actors_[var_84_12.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_12.prefab_name].transform, "story_v_out_317211", "317211020", "story_v_out_317211.awb")

						arg_81_1:RecordAudio("317211020", var_84_17)
						arg_81_1:RecordAudio("317211020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_317211", "317211020", "story_v_out_317211.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_317211", "317211020", "story_v_out_317211.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_18 and arg_81_1.time_ < var_84_10 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play317211021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317211021
		arg_85_1.duration_ = 5.8

		local var_85_0 = {
			zh = 4.4,
			ja = 5.8
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play317211022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1199ui_story = arg_85_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).z)
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles = arg_85_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_85_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1199ui_story"].transform.position).z)
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1199ui_story"].transform.localEulerAngles = arg_85_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1199ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1199ui_story == nil then
				arg_85_1.var_.characterEffect1199ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1199ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1199ui_story then
				arg_85_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = arg_85_1.actors_["1093ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect1093ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1093ui_story then
				arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_88_6 = 0
			local var_88_7 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(317211021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 22 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 22)

				if (22 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 22)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211021", "story_v_out_317211.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211021", "story_v_out_317211.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_317211", "317211021", "story_v_out_317211.awb")

						arg_85_1:RecordAudio("317211021", var_88_13)
						arg_85_1:RecordAudio("317211021", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317211", "317211021", "story_v_out_317211.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317211", "317211021", "story_v_out_317211.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play317211022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317211022
		arg_89_1.duration_ = 4.4

		local var_89_0 = {
			zh = 1.999999999999,
			ja = 4.4
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317211023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1093ui_story = arg_89_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).z)
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles = arg_89_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_89_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1093ui_story"].transform.position).z)
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1093ui_story"].transform.localEulerAngles = arg_89_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1093ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1093ui_story == nil then
				arg_89_1.var_.characterEffect1093ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1093ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1093ui_story then
				arg_89_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["1199ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1199ui_story == nil then
				arg_89_1.var_.characterEffect1199ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect1199ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1199ui_story then
				arg_89_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_92_6 = 0
			local var_92_7 = 0.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(317211022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 7 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 7)

				if (7 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 7)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211022", "story_v_out_317211.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211022", "story_v_out_317211.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_317211", "317211022", "story_v_out_317211.awb")

						arg_89_1:RecordAudio("317211022", var_92_13)
						arg_89_1:RecordAudio("317211022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317211", "317211022", "story_v_out_317211.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317211", "317211022", "story_v_out_317211.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play317211023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317211023
		arg_93_1.duration_ = 9

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317211024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.bgs_.STblack == nil then
				local var_96_0 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_96_0.name = "STblack"
				var_96_0.transform.parent = arg_93_1.stage_.transform
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_.STblack = var_96_0
			end

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				local var_96_1 = arg_93_1.bgs_.STblack

				arg_93_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_2 = var_96_1:GetComponent("SpriteRenderer")

				if var_96_2 and var_96_2.sprite then
					local var_96_3 = 2 * (var_96_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_1.transform.localScale = Vector3.New(var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "STblack" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_4 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_5 = 2

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_5 then
				local var_96_6 = Color.New(0, 0, 0)

				var_96_6.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_4) / var_96_5)
				arg_93_1.mask_.color = var_96_6
			end

			if arg_93_1.time_ >= var_96_4 + var_96_5 and arg_93_1.time_ < var_96_4 + var_96_5 + arg_96_0 then
				local var_96_7 = Color.New(0, 0, 0)

				var_96_7.a = 1
				arg_93_1.mask_.color = var_96_7
			end

			local var_96_8 = 2

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 then
				local var_96_10 = Color.New(0, 0, 0)

				var_96_10.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_8) / var_96_9)
				arg_93_1.mask_.color = var_96_10
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 then
				local var_96_11 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_11.a = 0
				arg_93_1.mask_.color = var_96_11
			end

			local var_96_12 = arg_93_1.actors_["1199ui_story"].transform

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				arg_93_1.var_.moveOldPos1199ui_story = var_96_12.localPosition
			end

			local var_96_13 = 0.001

			if 2 <= arg_93_1.time_ and arg_93_1.time_ < 2 + var_96_13 then
				var_96_12.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 2) / var_96_13)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			if arg_93_1.time_ >= 2 + var_96_13 and arg_93_1.time_ < 2 + var_96_13 + arg_96_0 then
				var_96_12.localPosition = Vector3.New(0, 100, 0)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			local var_96_14 = arg_93_1.actors_["1093ui_story"].transform

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = var_96_14.localPosition
			end

			local var_96_15 = 0.001

			if 2 <= arg_93_1.time_ and arg_93_1.time_ < 2 + var_96_15 then
				var_96_14.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 2) / var_96_15)
				var_96_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_14.position).x, (manager.ui.mainCamera.transform.position - var_96_14.position).y, (manager.ui.mainCamera.transform.position - var_96_14.position).z)
				var_96_14.localEulerAngles.z = 0
				var_96_14.localEulerAngles.x = 0
				var_96_14.localEulerAngles = var_96_14.localEulerAngles
			end

			if arg_93_1.time_ >= 2 + var_96_15 and arg_93_1.time_ < 2 + var_96_15 + arg_96_0 then
				var_96_14.localPosition = Vector3.New(0, 100, 0)
				var_96_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_14.position).x, (manager.ui.mainCamera.transform.position - var_96_14.position).y, (manager.ui.mainCamera.transform.position - var_96_14.position).z)
				var_96_14.localEulerAngles.z = 0
				var_96_14.localEulerAngles.x = 0
				var_96_14.localEulerAngles = var_96_14.localEulerAngles
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_16 = 4
			local var_96_17 = 1.225

			if 4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_18 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_18:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(317211023).content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 49 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 49)

				if (49 <= 0 and var_96_17 or var_96_17 * (utf8.len(var_96_19) / 49)) > 0 and var_96_17 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21
					var_96_16 = var_96_16 + 0.3

					if var_96_21 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = var_96_16 + 0.3
			local var_96_23 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_22 + var_96_23 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_22) / var_96_23

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_22 + var_96_23 and arg_93_1.time_ < var_96_22 + var_96_23 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play317211024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317211024
		arg_99_1.duration_ = 7.27

		local var_99_0 = {
			zh = 6.6,
			ja = 7.266
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play317211025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.bgs_.K09g == nil then
				local var_102_0 = Object.Instantiate(arg_99_1.paintGo_)

				var_102_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09g")
				var_102_0.name = "K09g"
				var_102_0.transform.parent = arg_99_1.stage_.transform
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.bgs_.K09g = var_102_0
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				local var_102_1 = arg_99_1.bgs_.K09g

				arg_99_1.bgs_.K09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_2 = var_102_1:GetComponent("SpriteRenderer")

				if var_102_2 and var_102_2.sprite then
					local var_102_3 = 2 * (var_102_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_1.transform.localScale = Vector3.New(var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, var_102_3 / var_102_2.sprite.bounds.size.y < var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x and var_102_3 * manager.ui.mainCameraCom_.aspect / var_102_2.sprite.bounds.size.x or var_102_3 / var_102_2.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "K09g" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_4 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_5 = 2

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_5 then
				local var_102_6 = Color.New(0, 0, 0)

				var_102_6.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_4) / var_102_5)
				arg_99_1.mask_.color = var_102_6
			end

			if arg_99_1.time_ >= var_102_4 + var_102_5 and arg_99_1.time_ < var_102_4 + var_102_5 + arg_102_0 then
				local var_102_7 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_7.a = 0
				arg_99_1.mask_.color = var_102_7
			end

			local var_102_8 = arg_99_1.actors_["1199ui_story"].transform

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1.var_.moveOldPos1199ui_story = var_102_8.localPosition
			end

			local var_102_9 = 0.001

			if 2 <= arg_99_1.time_ and arg_99_1.time_ < 2 + var_102_9 then
				var_102_8.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_99_1.time_ - 2) / var_102_9)
				var_102_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_8.position).x, (manager.ui.mainCamera.transform.position - var_102_8.position).y, (manager.ui.mainCamera.transform.position - var_102_8.position).z)
				var_102_8.localEulerAngles.z = 0
				var_102_8.localEulerAngles.x = 0
				var_102_8.localEulerAngles = var_102_8.localEulerAngles
			end

			if arg_99_1.time_ >= 2 + var_102_9 and arg_99_1.time_ < 2 + var_102_9 + arg_102_0 then
				var_102_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_102_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_8.position).x, (manager.ui.mainCamera.transform.position - var_102_8.position).y, (manager.ui.mainCamera.transform.position - var_102_8.position).z)
				var_102_8.localEulerAngles.z = 0
				var_102_8.localEulerAngles.x = 0
				var_102_8.localEulerAngles = var_102_8.localEulerAngles
			end

			local var_102_10 = arg_99_1.actors_["1199ui_story"]

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect1199ui_story == nil then
				arg_99_1.var_.characterEffect1199ui_story = var_102_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if 2 <= arg_99_1.time_ and arg_99_1.time_ < 2 + var_102_11 and not isNil(var_102_10) then
				if arg_99_1.var_.characterEffect1199ui_story and not isNil(var_102_10) then
					arg_99_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 2 + var_102_11 and arg_99_1.time_ < 2 + var_102_11 + arg_102_0 and not isNil(var_102_10) and arg_99_1.var_.characterEffect1199ui_story then
				arg_99_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_102_13 = arg_99_1.actors_["1093ui_story"].transform

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				arg_99_1.var_.moveOldPos1093ui_story = var_102_13.localPosition
			end

			local var_102_14 = 0.001

			if 2 <= arg_99_1.time_ and arg_99_1.time_ < 2 + var_102_14 then
				var_102_13.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_99_1.time_ - 2) / var_102_14)
				var_102_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_13.position).x, (manager.ui.mainCamera.transform.position - var_102_13.position).y, (manager.ui.mainCamera.transform.position - var_102_13.position).z)
				var_102_13.localEulerAngles.z = 0
				var_102_13.localEulerAngles.x = 0
				var_102_13.localEulerAngles = var_102_13.localEulerAngles
			end

			if arg_99_1.time_ >= 2 + var_102_14 and arg_99_1.time_ < 2 + var_102_14 + arg_102_0 then
				var_102_13.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_102_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_13.position).x, (manager.ui.mainCamera.transform.position - var_102_13.position).y, (manager.ui.mainCamera.transform.position - var_102_13.position).z)
				var_102_13.localEulerAngles.z = 0
				var_102_13.localEulerAngles.x = 0
				var_102_13.localEulerAngles = var_102_13.localEulerAngles
			end

			local var_102_15 = arg_99_1.actors_["1093ui_story"]

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 and not isNil(var_102_15) and arg_99_1.var_.characterEffect1093ui_story == nil then
				arg_99_1.var_.characterEffect1093ui_story = var_102_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_16 = 0.200000002980232

			if 2 <= arg_99_1.time_ and arg_99_1.time_ < 2 + var_102_16 and not isNil(var_102_15) then
				if arg_99_1.var_.characterEffect1093ui_story and not isNil(var_102_15) then
					arg_99_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 2) / var_102_16)
				end
			end

			if arg_99_1.time_ >= 2 + var_102_16 and arg_99_1.time_ < 2 + var_102_16 + arg_102_0 and not isNil(var_102_15) and arg_99_1.var_.characterEffect1093ui_story then
				arg_99_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_17 = 2
			local var_102_18 = 0.325

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_17 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_19 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_19:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_20 = arg_99_1:GetWordFromCfg(317211024)
				local var_102_21 = arg_99_1:FormatText(var_102_20.content)

				arg_99_1.text_.text = var_102_21

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_23 = 13 <= 0 and var_102_18 or var_102_18 * (utf8.len(var_102_21) / 13)

				if (13 <= 0 and var_102_18 or var_102_18 * (utf8.len(var_102_21) / 13)) > 0 and var_102_18 < var_102_23 then
					arg_99_1.talkMaxDuration = var_102_23
					var_102_17 = var_102_17 + 0.3

					if var_102_23 + var_102_17 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_17
					end
				end

				arg_99_1.text_.text = var_102_21
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211024", "story_v_out_317211.awb") ~= 0 then
					local var_102_24 = manager.audio:GetVoiceLength("story_v_out_317211", "317211024", "story_v_out_317211.awb") / 1000

					if var_102_24 + var_102_17 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_24 + var_102_17
					end

					if var_102_20.prefab_name ~= "" and arg_99_1.actors_[var_102_20.prefab_name] ~= nil then
						local var_102_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_20.prefab_name].transform, "story_v_out_317211", "317211024", "story_v_out_317211.awb")

						arg_99_1:RecordAudio("317211024", var_102_25)
						arg_99_1:RecordAudio("317211024", var_102_25)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_317211", "317211024", "story_v_out_317211.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_317211", "317211024", "story_v_out_317211.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_26 = var_102_17 + 0.3
			local var_102_27 = math.max(var_102_18, arg_99_1.talkMaxDuration)

			if var_102_17 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_26 + var_102_27 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_26) / var_102_27

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_26 + var_102_27 and arg_99_1.time_ < var_102_26 + var_102_27 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play317211025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317211025
		arg_105_1.duration_ = 6.97

		local var_105_0 = {
			zh = 5.833,
			ja = 6.966
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317211026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1093ui_story = arg_105_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).z)
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles = arg_105_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_105_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1093ui_story"].transform.position).z)
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1093ui_story"].transform.localEulerAngles = arg_105_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1093ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1093ui_story then
				arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_4 = arg_105_1.actors_["1199ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1199ui_story == nil then
				arg_105_1.var_.characterEffect1199ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_5 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 and not isNil(var_108_4) then
				if arg_105_1.var_.characterEffect1199ui_story and not isNil(var_108_4) then
					arg_105_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_5)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1199ui_story then
				arg_105_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_108_6 = 0
			local var_108_7 = 0.6

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(317211025)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 24 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 24)

				if (24 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 24)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211025", "story_v_out_317211.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211025", "story_v_out_317211.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_317211", "317211025", "story_v_out_317211.awb")

						arg_105_1:RecordAudio("317211025", var_108_13)
						arg_105_1:RecordAudio("317211025", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317211", "317211025", "story_v_out_317211.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317211", "317211025", "story_v_out_317211.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play317211026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317211026
		arg_109_1.duration_ = 9.9

		local var_109_0 = {
			zh = 9.9,
			ja = 9.5
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play317211027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.95

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(317211026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 38 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 38)

				if (38 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 38)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211026", "story_v_out_317211.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211026", "story_v_out_317211.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_317211", "317211026", "story_v_out_317211.awb")

						arg_109_1:RecordAudio("317211026", var_112_6)
						arg_109_1:RecordAudio("317211026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317211", "317211026", "story_v_out_317211.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317211", "317211026", "story_v_out_317211.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play317211027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317211027
		arg_113_1.duration_ = 7.37

		local var_113_0 = {
			zh = 7.366,
			ja = 6.366
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317211028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1199ui_story = arg_113_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1199ui_story"].transform.position).z)
				arg_113_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1199ui_story"].transform.localEulerAngles = arg_113_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1199ui_story"].transform.position).z)
				arg_113_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1199ui_story"].transform.localEulerAngles = arg_113_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1199ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1199ui_story == nil then
				arg_113_1.var_.characterEffect1199ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1199ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1199ui_story then
				arg_113_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_116_3 = arg_113_1.actors_["1093ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1093ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, 100, 0)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["1093ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1093ui_story == nil then
				arg_113_1.var_.characterEffect1093ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.characterEffect1093ui_story and not isNil(var_116_5) then
					arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_6)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1093ui_story then
				arg_113_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_116_7 = arg_113_1.actors_["1015ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1015ui_story = var_116_7.localPosition
			end

			local var_116_8 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_8 then
				var_116_7.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_113_1.time_ - 0) / var_116_8)
				var_116_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_7.position).x, (manager.ui.mainCamera.transform.position - var_116_7.position).y, (manager.ui.mainCamera.transform.position - var_116_7.position).z)
				var_116_7.localEulerAngles.z = 0
				var_116_7.localEulerAngles.x = 0
				var_116_7.localEulerAngles = var_116_7.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_8 and arg_113_1.time_ < 0 + var_116_8 + arg_116_0 then
				var_116_7.localPosition = Vector3.New(0, -1.15, -6.2)
				var_116_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_7.position).x, (manager.ui.mainCamera.transform.position - var_116_7.position).y, (manager.ui.mainCamera.transform.position - var_116_7.position).z)
				var_116_7.localEulerAngles.z = 0
				var_116_7.localEulerAngles.x = 0
				var_116_7.localEulerAngles = var_116_7.localEulerAngles
			end

			local var_116_9 = arg_113_1.actors_["1015ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1015ui_story == nil then
				arg_113_1.var_.characterEffect1015ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_10 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_10 and not isNil(var_116_9) then
				if arg_113_1.var_.characterEffect1015ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_10 and arg_113_1.time_ < 0 + var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1015ui_story then
				arg_113_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_12 = 0
			local var_116_13 = 0.725

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(317211027)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 29 <= 0 and var_116_13 or var_116_13 * (utf8.len(var_116_15) / 29)

				if (29 <= 0 and var_116_13 or var_116_13 * (utf8.len(var_116_15) / 29)) > 0 and var_116_13 < var_116_17 then
					arg_113_1.talkMaxDuration = var_116_17

					if var_116_17 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211027", "story_v_out_317211.awb") ~= 0 then
					local var_116_18 = manager.audio:GetVoiceLength("story_v_out_317211", "317211027", "story_v_out_317211.awb") / 1000

					if var_116_18 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_12
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_317211", "317211027", "story_v_out_317211.awb")

						arg_113_1:RecordAudio("317211027", var_116_19)
						arg_113_1:RecordAudio("317211027", var_116_19)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_317211", "317211027", "story_v_out_317211.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_317211", "317211027", "story_v_out_317211.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_20 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_20 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_20

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_20 and arg_113_1.time_ < var_116_12 + var_116_20 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play317211028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317211028
		arg_117_1.duration_ = 6.43

		local var_117_0 = {
			zh = 3.3,
			ja = 6.433
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play317211029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1199ui_story = arg_117_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).z)
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles = arg_117_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_117_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1199ui_story"].transform.position).z)
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1199ui_story"].transform.localEulerAngles = arg_117_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1199ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1199ui_story == nil then
				arg_117_1.var_.characterEffect1199ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1199ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1199ui_story then
				arg_117_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_120_4 = arg_117_1.actors_["1015ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1015ui_story = var_120_4.localPosition
			end

			local var_120_5 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				var_120_4.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_5)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				var_120_4.localPosition = Vector3.New(0, 100, 0)
				var_120_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_4.position).x, (manager.ui.mainCamera.transform.position - var_120_4.position).y, (manager.ui.mainCamera.transform.position - var_120_4.position).z)
				var_120_4.localEulerAngles.z = 0
				var_120_4.localEulerAngles.x = 0
				var_120_4.localEulerAngles = var_120_4.localEulerAngles
			end

			local var_120_6 = arg_117_1.actors_["1015ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1015ui_story == nil then
				arg_117_1.var_.characterEffect1015ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 and not isNil(var_120_6) then
				if arg_117_1.var_.characterEffect1015ui_story and not isNil(var_120_6) then
					arg_117_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_7)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1015ui_story then
				arg_117_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_120_8 = 0
			local var_120_9 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(317211028)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 13 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 13)

				if (13 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 13)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211028", "story_v_out_317211.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211028", "story_v_out_317211.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_317211", "317211028", "story_v_out_317211.awb")

						arg_117_1:RecordAudio("317211028", var_120_15)
						arg_117_1:RecordAudio("317211028", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_317211", "317211028", "story_v_out_317211.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_317211", "317211028", "story_v_out_317211.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play317211029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317211029
		arg_121_1.duration_ = 5.7

		local var_121_0 = {
			zh = 3.7,
			ja = 5.7
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317211030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1199ui_story = arg_121_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).z)
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles = arg_121_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1199ui_story"].transform.position).z)
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1199ui_story"].transform.localEulerAngles = arg_121_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1199ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1199ui_story == nil then
				arg_121_1.var_.characterEffect1199ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1199ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1199ui_story then
				arg_121_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["1015ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1015ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["1015ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1015ui_story == nil then
				arg_121_1.var_.characterEffect1015ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect1015ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1015ui_story then
				arg_121_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_8 = 0
			local var_124_9 = 0.35

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(317211029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 14 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 14)

				if (14 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 14)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211029", "story_v_out_317211.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211029", "story_v_out_317211.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_317211", "317211029", "story_v_out_317211.awb")

						arg_121_1:RecordAudio("317211029", var_124_15)
						arg_121_1:RecordAudio("317211029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317211", "317211029", "story_v_out_317211.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317211", "317211029", "story_v_out_317211.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play317211030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317211030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317211031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1015ui_story = arg_125_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1015ui_story"].transform.position).z)
				arg_125_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1015ui_story"].transform.localEulerAngles = arg_125_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1015ui_story"].transform.position).z)
				arg_125_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1015ui_story"].transform.localEulerAngles = arg_125_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1015ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1015ui_story == nil then
				arg_125_1.var_.characterEffect1015ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1015ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1015ui_story then
				arg_125_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_128_3 = 0
			local var_128_4 = 0.375

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_5 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(317211030).content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 15 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_5) / 15)

				if (15 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_5) / 15)) > 0 and var_128_4 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_3
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_4, arg_125_1.talkMaxDuration)

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_3) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_3 + var_128_8 and arg_125_1.time_ < var_128_3 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play317211031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317211031
		arg_129_1.duration_ = 12.43

		local var_129_0 = {
			zh = 11.666,
			ja = 12.433
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play317211032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1199ui_story = arg_129_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1199ui_story"].transform.position).z)
				arg_129_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1199ui_story"].transform.localEulerAngles = arg_129_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_129_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1199ui_story"].transform.position).z)
				arg_129_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1199ui_story"].transform.localEulerAngles = arg_129_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1199ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1199ui_story == nil then
				arg_129_1.var_.characterEffect1199ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1199ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1199ui_story then
				arg_129_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 1.1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(317211031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 44 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 44)

				if (44 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 44)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211031", "story_v_out_317211.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211031", "story_v_out_317211.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_317211", "317211031", "story_v_out_317211.awb")

						arg_129_1:RecordAudio("317211031", var_132_11)
						arg_129_1:RecordAudio("317211031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_317211", "317211031", "story_v_out_317211.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_317211", "317211031", "story_v_out_317211.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play317211032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317211032
		arg_133_1.duration_ = 11.17

		local var_133_0 = {
			zh = 11.166,
			ja = 9.3
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play317211033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(317211032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 51 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 51)

				if (51 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 51)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211032", "story_v_out_317211.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211032", "story_v_out_317211.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_317211", "317211032", "story_v_out_317211.awb")

						arg_133_1:RecordAudio("317211032", var_136_6)
						arg_133_1:RecordAudio("317211032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_317211", "317211032", "story_v_out_317211.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_317211", "317211032", "story_v_out_317211.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play317211033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317211033
		arg_137_1.duration_ = 5.2

		local var_137_0 = {
			zh = 4.4,
			ja = 5.2
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play317211034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.6

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(317211033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 24 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 24)

				if (24 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 24)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211033", "story_v_out_317211.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211033", "story_v_out_317211.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_317211", "317211033", "story_v_out_317211.awb")

						arg_137_1:RecordAudio("317211033", var_140_6)
						arg_137_1:RecordAudio("317211033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_317211", "317211033", "story_v_out_317211.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_317211", "317211033", "story_v_out_317211.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play317211034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317211034
		arg_141_1.duration_ = 6

		local var_141_0 = {
			zh = 3.6,
			ja = 6
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play317211035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1199ui_story = arg_141_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).z)
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles = arg_141_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1199ui_story"].transform.position).z)
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1199ui_story"].transform.localEulerAngles = arg_141_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1199ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1199ui_story == nil then
				arg_141_1.var_.characterEffect1199ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1199ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_2)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1199ui_story then
				arg_141_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_144_3 = arg_141_1.actors_["1093ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1093ui_story = var_144_3.localPosition
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_3.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_141_1.time_ - 0) / var_144_4)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			local var_144_5 = arg_141_1.actors_["1093ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_5) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_144_8 = 0
			local var_144_9 = 0.3

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(317211034)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 12 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 12)

				if (12 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 12)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211034", "story_v_out_317211.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211034", "story_v_out_317211.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_317211", "317211034", "story_v_out_317211.awb")

						arg_141_1:RecordAudio("317211034", var_144_15)
						arg_141_1:RecordAudio("317211034", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_317211", "317211034", "story_v_out_317211.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_317211", "317211034", "story_v_out_317211.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play317211035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317211035
		arg_145_1.duration_ = 13.73

		local var_145_0 = {
			zh = 11.5,
			ja = 13.733
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play317211036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1093ui_story = arg_145_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).z)
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles = arg_145_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1093ui_story"].transform.position).z)
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1093ui_story"].transform.localEulerAngles = arg_145_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1093ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1093ui_story == nil then
				arg_145_1.var_.characterEffect1093ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1093ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1093ui_story then
				arg_145_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_148_3 = arg_145_1.actors_["1199ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1199ui_story = var_148_3.localPosition
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_3.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_145_1.time_ - 0) / var_148_4)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			local var_148_5 = arg_145_1.actors_["1199ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1199ui_story == nil then
				arg_145_1.var_.characterEffect1199ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.characterEffect1199ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1199ui_story then
				arg_145_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_148_8 = 0
			local var_148_9 = 1.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(317211035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 46 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 46)

				if (46 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 46)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211035", "story_v_out_317211.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211035", "story_v_out_317211.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_317211", "317211035", "story_v_out_317211.awb")

						arg_145_1:RecordAudio("317211035", var_148_15)
						arg_145_1:RecordAudio("317211035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_317211", "317211035", "story_v_out_317211.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_317211", "317211035", "story_v_out_317211.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play317211036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317211036
		arg_149_1.duration_ = 15.3

		local var_149_0 = {
			zh = 13.133,
			ja = 15.3
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play317211037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.725

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(317211036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 69 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 69)

				if (69 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 69)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211036", "story_v_out_317211.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211036", "story_v_out_317211.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_317211", "317211036", "story_v_out_317211.awb")

						arg_149_1:RecordAudio("317211036", var_152_6)
						arg_149_1:RecordAudio("317211036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_317211", "317211036", "story_v_out_317211.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_317211", "317211036", "story_v_out_317211.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play317211037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 317211037
		arg_153_1.duration_ = 10.3

		local var_153_0 = {
			zh = 7.2,
			ja = 10.3
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play317211038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1199ui_story = arg_153_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1199ui_story"].transform.position).z)
				arg_153_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1199ui_story"].transform.localEulerAngles = arg_153_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1199ui_story"].transform.position).z)
				arg_153_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1199ui_story"].transform.localEulerAngles = arg_153_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1199ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1199ui_story == nil then
				arg_153_1.var_.characterEffect1199ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1199ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_2)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1199ui_story then
				arg_153_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_156_3 = arg_153_1.actors_["1093ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1093ui_story = var_156_3.localPosition
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_153_1.time_ - 0) / var_156_4)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			local var_156_5 = arg_153_1.actors_["1093ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.characterEffect1093ui_story and not isNil(var_156_5) then
					arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1093ui_story then
				arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_156_8 = 0
			local var_156_9 = 0.75

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(317211037)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 30 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 30)

				if (30 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 30)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211037", "story_v_out_317211.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211037", "story_v_out_317211.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_317211", "317211037", "story_v_out_317211.awb")

						arg_153_1:RecordAudio("317211037", var_156_15)
						arg_153_1:RecordAudio("317211037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_317211", "317211037", "story_v_out_317211.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_317211", "317211037", "story_v_out_317211.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play317211038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 317211038
		arg_157_1.duration_ = 4.3

		local var_157_0 = {
			zh = 2,
			ja = 4.3
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play317211039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1093ui_story = arg_157_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).z)
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles = arg_157_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1093ui_story"].transform.position).z)
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1093ui_story"].transform.localEulerAngles = arg_157_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1093ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1093ui_story == nil then
				arg_157_1.var_.characterEffect1093ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1093ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_2)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1093ui_story then
				arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_160_3 = arg_157_1.actors_["1199ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1199ui_story = var_160_3.localPosition
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_157_1.time_ - 0) / var_160_4)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			local var_160_5 = arg_157_1.actors_["1199ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect1199ui_story == nil then
				arg_157_1.var_.characterEffect1199ui_story = var_160_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.characterEffect1199ui_story and not isNil(var_160_5) then
					arg_157_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect1199ui_story then
				arg_157_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_160_8 = 0
			local var_160_9 = 0.225

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(317211038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 9 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 9)

				if (9 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 9)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211038", "story_v_out_317211.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_317211", "317211038", "story_v_out_317211.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_317211", "317211038", "story_v_out_317211.awb")

						arg_157_1:RecordAudio("317211038", var_160_15)
						arg_157_1:RecordAudio("317211038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_317211", "317211038", "story_v_out_317211.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_317211", "317211038", "story_v_out_317211.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play317211039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 317211039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play317211040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1199ui_story = arg_161_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1199ui_story"].transform.position).z)
				arg_161_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1199ui_story"].transform.localEulerAngles = arg_161_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1199ui_story"].transform.position).z)
				arg_161_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1199ui_story"].transform.localEulerAngles = arg_161_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1199ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1199ui_story == nil then
				arg_161_1.var_.characterEffect1199ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1199ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1199ui_story then
				arg_161_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_164_3 = 0
			local var_164_4 = 1.425

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(317211039).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 57 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 57)

				if (57 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 57)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play317211040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 317211040
		arg_165_1.duration_ = 7.3

		local var_165_0 = {
			zh = 5.7,
			ja = 7.3
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play317211041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1199ui_story = arg_165_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1199ui_story"].transform.position).z)
				arg_165_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1199ui_story"].transform.localEulerAngles = arg_165_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_165_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1199ui_story"].transform.position).z)
				arg_165_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1199ui_story"].transform.localEulerAngles = arg_165_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1199ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1199ui_story == nil then
				arg_165_1.var_.characterEffect1199ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1199ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1199ui_story then
				arg_165_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_4 = 0
			local var_168_5 = 0.8

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(317211040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 32 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 32)

				if (32 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 32)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211040", "story_v_out_317211.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211040", "story_v_out_317211.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_317211", "317211040", "story_v_out_317211.awb")

						arg_165_1:RecordAudio("317211040", var_168_11)
						arg_165_1:RecordAudio("317211040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_317211", "317211040", "story_v_out_317211.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_317211", "317211040", "story_v_out_317211.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play317211041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 317211041
		arg_169_1.duration_ = 10.6

		local var_169_0 = {
			zh = 10.6,
			ja = 8.7
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play317211042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1093ui_story = arg_169_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).z)
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles = arg_169_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_169_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1093ui_story"].transform.position).z)
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1093ui_story"].transform.localEulerAngles = arg_169_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1093ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1093ui_story == nil then
				arg_169_1.var_.characterEffect1093ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1093ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1093ui_story then
				arg_169_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_4 = arg_169_1.actors_["1199ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1199ui_story == nil then
				arg_169_1.var_.characterEffect1199ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_5 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 and not isNil(var_172_4) then
				if arg_169_1.var_.characterEffect1199ui_story and not isNil(var_172_4) then
					arg_169_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_5)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1199ui_story then
				arg_169_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_172_6 = 0
			local var_172_7 = 1.15

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_8 = arg_169_1:GetWordFromCfg(317211041)
				local var_172_9 = arg_169_1:FormatText(var_172_8.content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 46 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 46)

				if (46 <= 0 and var_172_7 or var_172_7 * (utf8.len(var_172_9) / 46)) > 0 and var_172_7 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_6
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211041", "story_v_out_317211.awb") ~= 0 then
					local var_172_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211041", "story_v_out_317211.awb") / 1000

					if var_172_12 + var_172_6 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_12 + var_172_6
					end

					if var_172_8.prefab_name ~= "" and arg_169_1.actors_[var_172_8.prefab_name] ~= nil then
						local var_172_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_8.prefab_name].transform, "story_v_out_317211", "317211041", "story_v_out_317211.awb")

						arg_169_1:RecordAudio("317211041", var_172_13)
						arg_169_1:RecordAudio("317211041", var_172_13)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_317211", "317211041", "story_v_out_317211.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_317211", "317211041", "story_v_out_317211.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_14 = math.max(var_172_7, arg_169_1.talkMaxDuration)

			if var_172_6 <= arg_169_1.time_ and arg_169_1.time_ < var_172_6 + var_172_14 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_6) / var_172_14

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_6 + var_172_14 and arg_169_1.time_ < var_172_6 + var_172_14 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play317211042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 317211042
		arg_173_1.duration_ = 8.97

		local var_173_0 = {
			zh = 2.1,
			ja = 8.966
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play317211043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1199ui_story = arg_173_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1199ui_story"].transform.position).z)
				arg_173_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1199ui_story"].transform.localEulerAngles = arg_173_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_173_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1199ui_story"].transform.position).z)
				arg_173_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1199ui_story"].transform.localEulerAngles = arg_173_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1199ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1199ui_story == nil then
				arg_173_1.var_.characterEffect1199ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1199ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1199ui_story then
				arg_173_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_176_4 = arg_173_1.actors_["1093ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1093ui_story == nil then
				arg_173_1.var_.characterEffect1093ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_5 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 and not isNil(var_176_4) then
				if arg_173_1.var_.characterEffect1093ui_story and not isNil(var_176_4) then
					arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_5)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect1093ui_story then
				arg_173_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_176_6 = 0
			local var_176_7 = 0.275

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(317211042)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 11 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 11)

				if (11 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 11)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211042", "story_v_out_317211.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211042", "story_v_out_317211.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_317211", "317211042", "story_v_out_317211.awb")

						arg_173_1:RecordAudio("317211042", var_176_13)
						arg_173_1:RecordAudio("317211042", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_317211", "317211042", "story_v_out_317211.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_317211", "317211042", "story_v_out_317211.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play317211043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 317211043
		arg_177_1.duration_ = 7.6

		local var_177_0 = {
			zh = 3.333,
			ja = 7.6
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play317211044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1093ui_story = arg_177_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).z)
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles = arg_177_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_177_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1093ui_story"].transform.position).z)
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1093ui_story"].transform.localEulerAngles = arg_177_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1093ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1093ui_story == nil then
				arg_177_1.var_.characterEffect1093ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1093ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1093ui_story then
				arg_177_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_4 = arg_177_1.actors_["1199ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1199ui_story == nil then
				arg_177_1.var_.characterEffect1199ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_5 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_5 and not isNil(var_180_4) then
				if arg_177_1.var_.characterEffect1199ui_story and not isNil(var_180_4) then
					arg_177_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_5)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_5 and arg_177_1.time_ < 0 + var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1199ui_story then
				arg_177_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_180_6 = 0
			local var_180_7 = 0.4

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(317211043)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 16 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 16)

				if (16 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 16)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211043", "story_v_out_317211.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211043", "story_v_out_317211.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_317211", "317211043", "story_v_out_317211.awb")

						arg_177_1:RecordAudio("317211043", var_180_13)
						arg_177_1:RecordAudio("317211043", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_317211", "317211043", "story_v_out_317211.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_317211", "317211043", "story_v_out_317211.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play317211044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 317211044
		arg_181_1.duration_ = 6.8

		local var_181_0 = {
			zh = 1.999999999999,
			ja = 6.8
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play317211045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1199ui_story = arg_181_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1199ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).z)
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles = arg_181_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_181_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1199ui_story"].transform.position).z)
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1199ui_story"].transform.localEulerAngles = arg_181_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1199ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1199ui_story == nil then
				arg_181_1.var_.characterEffect1199ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1199ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1199ui_story then
				arg_181_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_184_4 = arg_181_1.actors_["1093ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1093ui_story == nil then
				arg_181_1.var_.characterEffect1093ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_5 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 and not isNil(var_184_4) then
				if arg_181_1.var_.characterEffect1093ui_story and not isNil(var_184_4) then
					arg_181_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_5)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1093ui_story then
				arg_181_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_184_6 = 0
			local var_184_7 = 0.175

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(317211044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 7 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 7)

				if (7 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 7)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211044", "story_v_out_317211.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211044", "story_v_out_317211.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_317211", "317211044", "story_v_out_317211.awb")

						arg_181_1:RecordAudio("317211044", var_184_13)
						arg_181_1:RecordAudio("317211044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_317211", "317211044", "story_v_out_317211.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_317211", "317211044", "story_v_out_317211.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play317211045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 317211045
		arg_185_1.duration_ = 10.03

		local var_185_0 = {
			zh = 6.233,
			ja = 10.033
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play317211046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_0 = 0
			local var_188_1 = 0.925

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(317211045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 36 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 36)

				if (36 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 36)) > 0 and var_188_1 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211045", "story_v_out_317211.awb") ~= 0 then
					local var_188_6 = manager.audio:GetVoiceLength("story_v_out_317211", "317211045", "story_v_out_317211.awb") / 1000

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end

					if var_188_2.prefab_name ~= "" and arg_185_1.actors_[var_188_2.prefab_name] ~= nil then
						local var_188_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_2.prefab_name].transform, "story_v_out_317211", "317211045", "story_v_out_317211.awb")

						arg_185_1:RecordAudio("317211045", var_188_7)
						arg_185_1:RecordAudio("317211045", var_188_7)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_317211", "317211045", "story_v_out_317211.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_317211", "317211045", "story_v_out_317211.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play317211046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 317211046
		arg_189_1.duration_ = 10.57

		local var_189_0 = {
			zh = 8.833,
			ja = 10.566
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play317211047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(317211046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 44 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 44)

				if (44 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 44)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211046", "story_v_out_317211.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211046", "story_v_out_317211.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_317211", "317211046", "story_v_out_317211.awb")

						arg_189_1:RecordAudio("317211046", var_192_6)
						arg_189_1:RecordAudio("317211046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_317211", "317211046", "story_v_out_317211.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_317211", "317211046", "story_v_out_317211.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play317211047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 317211047
		arg_193_1.duration_ = 2.8

		local var_193_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play317211048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1093ui_story = arg_193_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).z)
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles = arg_193_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_193_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1093ui_story"].transform.position).z)
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1093ui_story"].transform.localEulerAngles = arg_193_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1093ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1093ui_story == nil then
				arg_193_1.var_.characterEffect1093ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1093ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1093ui_story then
				arg_193_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_4 = arg_193_1.actors_["1199ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1199ui_story == nil then
				arg_193_1.var_.characterEffect1199ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_5 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 and not isNil(var_196_4) then
				if arg_193_1.var_.characterEffect1199ui_story and not isNil(var_196_4) then
					arg_193_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_5)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1199ui_story then
				arg_193_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_196_6 = 0
			local var_196_7 = 0.075

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(317211047)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 3 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 3)

				if (3 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 3)) > 0 and var_196_7 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211047", "story_v_out_317211.awb") ~= 0 then
					local var_196_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211047", "story_v_out_317211.awb") / 1000

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end

					if var_196_8.prefab_name ~= "" and arg_193_1.actors_[var_196_8.prefab_name] ~= nil then
						local var_196_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_8.prefab_name].transform, "story_v_out_317211", "317211047", "story_v_out_317211.awb")

						arg_193_1:RecordAudio("317211047", var_196_13)
						arg_193_1:RecordAudio("317211047", var_196_13)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_317211", "317211047", "story_v_out_317211.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_317211", "317211047", "story_v_out_317211.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play317211048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 317211048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play317211049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1199ui_story = arg_197_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1199ui_story"].transform.position).z)
				arg_197_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1199ui_story"].transform.localEulerAngles = arg_197_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1199ui_story"].transform.position).z)
				arg_197_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1199ui_story"].transform.localEulerAngles = arg_197_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1093ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1093ui_story = var_200_1.localPosition
			end

			local var_200_2 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 then
				var_200_1.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_2)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 then
				var_200_1.localPosition = Vector3.New(0, 100, 0)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			local var_200_3 = 0
			local var_200_4 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_5 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(317211048).content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 27 <= 0 and var_200_4 or var_200_4 * (utf8.len(var_200_5) / 27)

				if (27 <= 0 and var_200_4 or var_200_4 * (utf8.len(var_200_5) / 27)) > 0 and var_200_4 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_3 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_3
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_4, arg_197_1.talkMaxDuration)

			if var_200_3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_3 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_3) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_3 + var_200_8 and arg_197_1.time_ < var_200_3 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play317211049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 317211049
		arg_201_1.duration_ = 5

		local var_201_0 = {
			zh = 2.6,
			ja = 5
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play317211050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1015ui_story = arg_201_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).z)
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles = arg_201_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_201_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1015ui_story"].transform.position).z)
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1015ui_story"].transform.localEulerAngles = arg_201_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1015ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1015ui_story == nil then
				arg_201_1.var_.characterEffect1015ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1015ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1015ui_story then
				arg_201_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_4 = 0
			local var_204_5 = 0.35

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(317211049)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 14 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 14)

				if (14 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 14)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211049", "story_v_out_317211.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211049", "story_v_out_317211.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_317211", "317211049", "story_v_out_317211.awb")

						arg_201_1:RecordAudio("317211049", var_204_11)
						arg_201_1:RecordAudio("317211049", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_317211", "317211049", "story_v_out_317211.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_317211", "317211049", "story_v_out_317211.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play317211050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 317211050
		arg_205_1.duration_ = 14.87

		local var_205_0 = {
			zh = 11.8,
			ja = 14.866
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play317211051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1199ui_story = arg_205_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1199ui_story"].transform.position).z)
				arg_205_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1199ui_story"].transform.localEulerAngles = arg_205_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_205_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1199ui_story"].transform.position).z)
				arg_205_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1199ui_story"].transform.localEulerAngles = arg_205_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1199ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1199ui_story == nil then
				arg_205_1.var_.characterEffect1199ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1199ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1199ui_story then
				arg_205_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_208_4 = arg_205_1.actors_["1015ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1015ui_story == nil then
				arg_205_1.var_.characterEffect1015ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_5 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_5 and not isNil(var_208_4) then
				if arg_205_1.var_.characterEffect1015ui_story and not isNil(var_208_4) then
					arg_205_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_5)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_5 and arg_205_1.time_ < 0 + var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1015ui_story then
				arg_205_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_208_6 = 0
			local var_208_7 = 1.425

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_8 = arg_205_1:GetWordFromCfg(317211050)
				local var_208_9 = arg_205_1:FormatText(var_208_8.content)

				arg_205_1.text_.text = var_208_9

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 57 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 57)

				if (57 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 57)) > 0 and var_208_7 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_9
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211050", "story_v_out_317211.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211050", "story_v_out_317211.awb") / 1000

					if var_208_12 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_6
					end

					if var_208_8.prefab_name ~= "" and arg_205_1.actors_[var_208_8.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_8.prefab_name].transform, "story_v_out_317211", "317211050", "story_v_out_317211.awb")

						arg_205_1:RecordAudio("317211050", var_208_13)
						arg_205_1:RecordAudio("317211050", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_317211", "317211050", "story_v_out_317211.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_317211", "317211050", "story_v_out_317211.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_14 and arg_205_1.time_ < var_208_6 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play317211051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 317211051
		arg_209_1.duration_ = 2

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play317211052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1015ui_story = arg_209_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).z)
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles = arg_209_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_209_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1015ui_story"].transform.position).z)
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1015ui_story"].transform.localEulerAngles = arg_209_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1015ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1015ui_story == nil then
				arg_209_1.var_.characterEffect1015ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1015ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1015ui_story then
				arg_209_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_212_4 = arg_209_1.actors_["1199ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1199ui_story == nil then
				arg_209_1.var_.characterEffect1199ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect1199ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1199ui_story then
				arg_209_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_212_6 = 0
			local var_212_7 = 0.1

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(317211051)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 4 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 4)

				if (4 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 4)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211051", "story_v_out_317211.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211051", "story_v_out_317211.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_317211", "317211051", "story_v_out_317211.awb")

						arg_209_1:RecordAudio("317211051", var_212_13)
						arg_209_1:RecordAudio("317211051", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_317211", "317211051", "story_v_out_317211.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_317211", "317211051", "story_v_out_317211.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play317211052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 317211052
		arg_213_1.duration_ = 5.93

		local var_213_0 = {
			zh = 5.933,
			ja = 5.8
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play317211053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_0 = 0
			local var_216_1 = 0.675

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_2 = arg_213_1:GetWordFromCfg(317211052)
				local var_216_3 = arg_213_1:FormatText(var_216_2.content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 27 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_3) / 27)

				if (27 <= 0 and var_216_1 or var_216_1 * (utf8.len(var_216_3) / 27)) > 0 and var_216_1 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211052", "story_v_out_317211.awb") ~= 0 then
					local var_216_6 = manager.audio:GetVoiceLength("story_v_out_317211", "317211052", "story_v_out_317211.awb") / 1000

					if var_216_6 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_0
					end

					if var_216_2.prefab_name ~= "" and arg_213_1.actors_[var_216_2.prefab_name] ~= nil then
						local var_216_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_2.prefab_name].transform, "story_v_out_317211", "317211052", "story_v_out_317211.awb")

						arg_213_1:RecordAudio("317211052", var_216_7)
						arg_213_1:RecordAudio("317211052", var_216_7)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_317211", "317211052", "story_v_out_317211.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_317211", "317211052", "story_v_out_317211.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play317211053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 317211053
		arg_217_1.duration_ = 4.4

		local var_217_0 = {
			zh = 4.4,
			ja = 3.266
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play317211054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1199ui_story = arg_217_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1199ui_story"].transform.position).z)
				arg_217_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1199ui_story"].transform.localEulerAngles = arg_217_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_217_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1199ui_story"].transform.position).z)
				arg_217_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1199ui_story"].transform.localEulerAngles = arg_217_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1199ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1199ui_story == nil then
				arg_217_1.var_.characterEffect1199ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1199ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1199ui_story then
				arg_217_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_220_4 = arg_217_1.actors_["1015ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect1015ui_story == nil then
				arg_217_1.var_.characterEffect1015ui_story = var_220_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_5 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 and not isNil(var_220_4) then
				if arg_217_1.var_.characterEffect1015ui_story and not isNil(var_220_4) then
					arg_217_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_5)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect1015ui_story then
				arg_217_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_220_6 = 0
			local var_220_7 = 0.4

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(317211053)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 16 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 16)

				if (16 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 16)) > 0 and var_220_7 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211053", "story_v_out_317211.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211053", "story_v_out_317211.awb") / 1000

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end

					if var_220_8.prefab_name ~= "" and arg_217_1.actors_[var_220_8.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_8.prefab_name].transform, "story_v_out_317211", "317211053", "story_v_out_317211.awb")

						arg_217_1:RecordAudio("317211053", var_220_13)
						arg_217_1:RecordAudio("317211053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_317211", "317211053", "story_v_out_317211.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_317211", "317211053", "story_v_out_317211.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play317211054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 317211054
		arg_221_1.duration_ = 9.97

		local var_221_0 = {
			zh = 9.966,
			ja = 7.566
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play317211055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.45

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(317211054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 58 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 58)

				if (58 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 58)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211054", "story_v_out_317211.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211054", "story_v_out_317211.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_317211", "317211054", "story_v_out_317211.awb")

						arg_221_1:RecordAudio("317211054", var_224_6)
						arg_221_1:RecordAudio("317211054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_317211", "317211054", "story_v_out_317211.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_317211", "317211054", "story_v_out_317211.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play317211055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 317211055
		arg_225_1.duration_ = 12.77

		local var_225_0 = {
			zh = 12.766,
			ja = 12.533
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play317211056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.6

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(317211055)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 64 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 64)

				if (64 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 64)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211055", "story_v_out_317211.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211055", "story_v_out_317211.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_317211", "317211055", "story_v_out_317211.awb")

						arg_225_1:RecordAudio("317211055", var_228_6)
						arg_225_1:RecordAudio("317211055", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_317211", "317211055", "story_v_out_317211.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_317211", "317211055", "story_v_out_317211.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play317211056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 317211056
		arg_229_1.duration_ = 15.57

		local var_229_0 = {
			zh = 5.933,
			ja = 15.566
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play317211057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.875

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(317211056)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 35 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 35)

				if (35 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 35)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211056", "story_v_out_317211.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_317211", "317211056", "story_v_out_317211.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_317211", "317211056", "story_v_out_317211.awb")

						arg_229_1:RecordAudio("317211056", var_232_6)
						arg_229_1:RecordAudio("317211056", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_317211", "317211056", "story_v_out_317211.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_317211", "317211056", "story_v_out_317211.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play317211057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 317211057
		arg_233_1.duration_ = 8.7

		local var_233_0 = {
			zh = 6.666,
			ja = 8.7
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play317211058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1015ui_story = arg_233_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).z)
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles = arg_233_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_233_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1015ui_story"].transform.position).z)
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1015ui_story"].transform.localEulerAngles = arg_233_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1015ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1015ui_story == nil then
				arg_233_1.var_.characterEffect1015ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1015ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1015ui_story then
				arg_233_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = arg_233_1.actors_["1199ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1199ui_story == nil then
				arg_233_1.var_.characterEffect1199ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_5 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 and not isNil(var_236_4) then
				if arg_233_1.var_.characterEffect1199ui_story and not isNil(var_236_4) then
					arg_233_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_5)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect1199ui_story then
				arg_233_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_236_6 = 0
			local var_236_7 = 0.75

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(317211057)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 30 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_9) / 30)

				if (30 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_9) / 30)) > 0 and var_236_7 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211057", "story_v_out_317211.awb") ~= 0 then
					local var_236_12 = manager.audio:GetVoiceLength("story_v_out_317211", "317211057", "story_v_out_317211.awb") / 1000

					if var_236_12 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_6
					end

					if var_236_8.prefab_name ~= "" and arg_233_1.actors_[var_236_8.prefab_name] ~= nil then
						local var_236_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_8.prefab_name].transform, "story_v_out_317211", "317211057", "story_v_out_317211.awb")

						arg_233_1:RecordAudio("317211057", var_236_13)
						arg_233_1:RecordAudio("317211057", var_236_13)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_317211", "317211057", "story_v_out_317211.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_317211", "317211057", "story_v_out_317211.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_14 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_14 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_14

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_14 and arg_233_1.time_ < var_236_6 + var_236_14 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play317211058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 317211058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play317211059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1015ui_story"]) and arg_237_1.var_.characterEffect1015ui_story == nil then
				arg_237_1.var_.characterEffect1015ui_story = arg_237_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1015ui_story"]) then
				if arg_237_1.var_.characterEffect1015ui_story and not isNil(arg_237_1.actors_["1015ui_story"]) then
					arg_237_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1015ui_story"]) and arg_237_1.var_.characterEffect1015ui_story then
				arg_237_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_240_1 = arg_237_1.actors_["1015ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1015ui_story == nil then
				arg_237_1.var_.characterEffect1015ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1015ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_2)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1015ui_story then
				arg_237_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_240_3 = 0
			local var_240_4 = 0.45

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_3 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_5 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(317211058).content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 18 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_5) / 18)

				if (18 <= 0 and var_240_4 or var_240_4 * (utf8.len(var_240_5) / 18)) > 0 and var_240_4 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_3 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_3
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_8 = math.max(var_240_4, arg_237_1.talkMaxDuration)

			if var_240_3 <= arg_237_1.time_ and arg_237_1.time_ < var_240_3 + var_240_8 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_3) / var_240_8

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_3 + var_240_8 and arg_237_1.time_ < var_240_3 + var_240_8 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play317211059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 317211059
		arg_241_1.duration_ = 10.53

		local var_241_0 = {
			zh = 6.766,
			ja = 10.533
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play317211060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1199ui_story = arg_241_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1199ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1199ui_story"].transform.position).z)
				arg_241_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1199ui_story"].transform.localEulerAngles = arg_241_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_241_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1199ui_story"].transform.position).z)
				arg_241_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1199ui_story"].transform.localEulerAngles = arg_241_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1199ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1199ui_story == nil then
				arg_241_1.var_.characterEffect1199ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1199ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1199ui_story then
				arg_241_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.8

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(317211059)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 32 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 32)

				if (32 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 32)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211059", "story_v_out_317211.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211059", "story_v_out_317211.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_317211", "317211059", "story_v_out_317211.awb")

						arg_241_1:RecordAudio("317211059", var_244_11)
						arg_241_1:RecordAudio("317211059", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_317211", "317211059", "story_v_out_317211.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_317211", "317211059", "story_v_out_317211.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play317211060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 317211060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play317211061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1015ui_story = arg_245_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).z)
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles = arg_245_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1015ui_story"].transform.position).z)
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1015ui_story"].transform.localEulerAngles = arg_245_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1015ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1015ui_story == nil then
				arg_245_1.var_.characterEffect1015ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1015ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_2)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1015ui_story then
				arg_245_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_248_3 = arg_245_1.actors_["1199ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1199ui_story = var_248_3.localPosition
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_3.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_4)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_3.localPosition = Vector3.New(0, 100, 0)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			local var_248_5 = arg_245_1.actors_["1199ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1199ui_story == nil then
				arg_245_1.var_.characterEffect1199ui_story = var_248_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.characterEffect1199ui_story and not isNil(var_248_5) then
					arg_245_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_6)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1199ui_story then
				arg_245_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_gunfar", "")
			end

			local var_248_8 = 0
			local var_248_9 = 0.575

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(317211060).content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_12 = 23 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_10) / 23)

				if (23 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_10) / 23)) > 0 and var_248_9 < var_248_12 then
					arg_245_1.talkMaxDuration = var_248_12

					if var_248_12 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_13 and arg_245_1.time_ < var_248_8 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play317211061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 317211061
		arg_249_1.duration_ = 4.8

		local var_249_0 = {
			zh = 1.999999999999,
			ja = 4.8
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play317211062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1093ui_story = arg_249_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).z)
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles = arg_249_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_249_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1093ui_story"].transform.position).z)
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1093ui_story"].transform.localEulerAngles = arg_249_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1093ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1093ui_story == nil then
				arg_249_1.var_.characterEffect1093ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1093ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1093ui_story then
				arg_249_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.15

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(317211061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 5 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 5)

				if (5 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 5)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211061", "story_v_out_317211.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211061", "story_v_out_317211.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_317211", "317211061", "story_v_out_317211.awb")

						arg_249_1:RecordAudio("317211061", var_252_11)
						arg_249_1:RecordAudio("317211061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_317211", "317211061", "story_v_out_317211.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_317211", "317211061", "story_v_out_317211.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play317211062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 317211062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play317211063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1093ui_story = arg_253_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).z)
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles = arg_253_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1093ui_story"].transform.position).z)
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1093ui_story"].transform.localEulerAngles = arg_253_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1093ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1093ui_story == nil then
				arg_253_1.var_.characterEffect1093ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1093ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_2)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1093ui_story then
				arg_253_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_256_3 = 0
			local var_256_4 = 0.35

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(317211062).content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 14 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 14)

				if (14 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 14)) > 0 and var_256_4 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_8 and arg_253_1.time_ < var_256_3 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play317211063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 317211063
		arg_257_1.duration_ = 4.47

		local var_257_0 = {
			zh = 4.466,
			ja = 3.766
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
			arg_257_1.auto_ = false
		end

		function arg_257_1.playNext_(arg_259_0)
			arg_257_1.onStoryFinished_()
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1199ui_story = arg_257_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1199ui_story"].transform.position).z)
				arg_257_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1199ui_story"].transform.localEulerAngles = arg_257_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_257_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1199ui_story"].transform.position).z)
				arg_257_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1199ui_story"].transform.localEulerAngles = arg_257_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1199ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1199ui_story == nil then
				arg_257_1.var_.characterEffect1199ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1199ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1199ui_story then
				arg_257_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.675

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(317211063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 26 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 26)

				if (26 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 26)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317211", "317211063", "story_v_out_317211.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_317211", "317211063", "story_v_out_317211.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_317211", "317211063", "story_v_out_317211.awb")

						arg_257_1:RecordAudio("317211063", var_260_11)
						arg_257_1:RecordAudio("317211063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_317211", "317211063", "story_v_out_317211.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_317211", "317211063", "story_v_out_317211.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K09g"
	},
	voices = {
		"story_v_out_317211.awb"
	}
}
