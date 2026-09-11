return {
	Play412041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412041001
		arg_1_1.duration_ = 6.8

		local var_1_0 = {
			zh = 6,
			ja = 6.8
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST30 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST30")
				var_4_0.name = "ST30"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST30 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST30

				arg_1_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST30" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.00000000298023

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "10078ui_story"

			if arg_1_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["10078ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10078ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.5, -6.3)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10078ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10078ui_story == nil then
				arg_1_1.var_.characterEffect10078ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10078ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10078ui_story then
				arg_1_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_house_nightmare", "bgm_activity_3_2_story_house_nightmare", "bgm_activity_3_2_story_house_nightmare.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_2_story_house_nightmare", "bgm_activity_3_2_story_house_nightmare")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 2
			local var_4_25 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(412041001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 10)

				if (10 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 10)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041001", "story_v_out_412041.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_412041", "412041001", "story_v_out_412041.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_412041", "412041001", "story_v_out_412041.awb")

						arg_1_1:RecordAudio("412041001", var_4_32)
						arg_1_1:RecordAudio("412041001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412041", "412041001", "story_v_out_412041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412041", "412041001", "story_v_out_412041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play412041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412041002
		arg_9_1.duration_ = 4.97

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 4.966
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
				arg_9_0:Play412041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10083ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10083ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10083ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10083ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10083ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10083ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10083ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10083ui_story, Vector3.New(-1, -2.6, -2.8), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-1, -2.6, -2.8)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10083ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10083ui_story == nil then
				arg_9_1.var_.characterEffect10083ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10083ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10083ui_story then
				arg_9_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["10078ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10078ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, 100, 0)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10078ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10078ui_story == nil then
				arg_9_1.var_.characterEffect10078ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10078ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10078ui_story then
				arg_9_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(412041002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 8 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 8)

				if (8 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 8)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041002", "story_v_out_412041.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_412041", "412041002", "story_v_out_412041.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_412041", "412041002", "story_v_out_412041.awb")

						arg_9_1:RecordAudio("412041002", var_12_19)
						arg_9_1:RecordAudio("412041002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412041", "412041002", "story_v_out_412041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412041", "412041002", "story_v_out_412041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_20 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_20 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_20

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_20 and arg_9_1.time_ < var_12_12 + var_12_20 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412041003
		arg_13_1.duration_ = 11.1

		local var_13_0 = {
			zh = 4.733,
			ja = 11.1
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
				arg_13_0:Play412041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1097ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1097ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1097ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1097ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1097ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1097ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_16_8 = arg_13_1.actors_["10083ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.characterEffect10083ui_story == nil then
				arg_13_1.var_.characterEffect10083ui_story = var_16_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_9 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.characterEffect10083ui_story and not isNil(var_16_8) then
					arg_13_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_9)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.characterEffect10083ui_story then
				arg_13_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_16_10 = 0
			local var_16_11 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(412041003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 16 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 16)

				if (16 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 16)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041003", "story_v_out_412041.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_412041", "412041003", "story_v_out_412041.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_412041", "412041003", "story_v_out_412041.awb")

						arg_13_1:RecordAudio("412041003", var_16_17)
						arg_13_1:RecordAudio("412041003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412041", "412041003", "story_v_out_412041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412041", "412041003", "story_v_out_412041.awb")
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
				actorName = "1097ui_story",
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
	Play412041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412041004
		arg_17_1.duration_ = 8.3

		local var_17_0 = {
			zh = 8.3,
			ja = 7.6
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10083ui_story"]) and arg_17_1.var_.characterEffect10083ui_story == nil then
				arg_17_1.var_.characterEffect10083ui_story = arg_17_1.actors_["10083ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10083ui_story"]) then
				if arg_17_1.var_.characterEffect10083ui_story and not isNil(arg_17_1.actors_["10083ui_story"]) then
					arg_17_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10083ui_story"]) and arg_17_1.var_.characterEffect10083ui_story then
				arg_17_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083actionlink/10083action443")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = arg_17_1.actors_["1097ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 1.05

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(412041004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 42 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 42)

				if (42 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 42)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041004", "story_v_out_412041.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041004", "story_v_out_412041.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_412041", "412041004", "story_v_out_412041.awb")

						arg_17_1:RecordAudio("412041004", var_20_11)
						arg_17_1:RecordAudio("412041004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412041", "412041004", "story_v_out_412041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412041", "412041004", "story_v_out_412041.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play412041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412041005
		arg_21_1.duration_ = 7.5

		local var_21_0 = {
			zh = 7.133,
			ja = 7.5
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
				arg_21_0:Play412041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1097ui_story"]) and arg_21_1.var_.characterEffect1097ui_story == nil then
				arg_21_1.var_.characterEffect1097ui_story = arg_21_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1097ui_story"]) then
				if arg_21_1.var_.characterEffect1097ui_story and not isNil(arg_21_1.actors_["1097ui_story"]) then
					arg_21_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1097ui_story"]) and arg_21_1.var_.characterEffect1097ui_story then
				arg_21_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = arg_21_1.actors_["10083ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect10083ui_story == nil then
				arg_21_1.var_.characterEffect10083ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect10083ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect10083ui_story then
				arg_21_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(412041005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)

				if (25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041005", "story_v_out_412041.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041005", "story_v_out_412041.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_412041", "412041005", "story_v_out_412041.awb")

						arg_21_1:RecordAudio("412041005", var_24_11)
						arg_21_1:RecordAudio("412041005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_412041", "412041005", "story_v_out_412041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_412041", "412041005", "story_v_out_412041.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play412041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412041006
		arg_25_1.duration_ = 11.77

		local var_25_0 = {
			zh = 11.766,
			ja = 11.733
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
				arg_25_0:Play412041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(412041006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 47 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 47)

				if (47 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 47)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041006", "story_v_out_412041.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_412041", "412041006", "story_v_out_412041.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_412041", "412041006", "story_v_out_412041.awb")

						arg_25_1:RecordAudio("412041006", var_28_6)
						arg_25_1:RecordAudio("412041006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412041", "412041006", "story_v_out_412041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412041", "412041006", "story_v_out_412041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play412041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412041007
		arg_29_1.duration_ = 8.27

		local var_29_0 = {
			zh = 5.3,
			ja = 8.266
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
				arg_29_0:Play412041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "10076ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10076ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["10076ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["10076ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["10076ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["10076ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10076ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.35, -4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["10076ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10076ui_story == nil then
				arg_29_1.var_.characterEffect10076ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10076ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10076ui_story then
				arg_29_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_8 = arg_29_1.actors_["10083ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10083ui_story = var_32_8.localPosition
			end

			local var_32_9 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_9)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0, 100, 0)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			local var_32_10 = arg_29_1.actors_["10083ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect10083ui_story == nil then
				arg_29_1.var_.characterEffect10083ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect10083ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_11 and arg_29_1.time_ < 0 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect10083ui_story then
				arg_29_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_32_12 = arg_29_1.actors_["1097ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_12.localPosition
			end

			local var_32_13 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_13 then
				var_32_12.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_13)
				var_32_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_12.position).x, (manager.ui.mainCamera.transform.position - var_32_12.position).y, (manager.ui.mainCamera.transform.position - var_32_12.position).z)
				var_32_12.localEulerAngles.z = 0
				var_32_12.localEulerAngles.x = 0
				var_32_12.localEulerAngles = var_32_12.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_13 and arg_29_1.time_ < 0 + var_32_13 + arg_32_0 then
				var_32_12.localPosition = Vector3.New(0, 100, 0)
				var_32_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_12.position).x, (manager.ui.mainCamera.transform.position - var_32_12.position).y, (manager.ui.mainCamera.transform.position - var_32_12.position).z)
				var_32_12.localEulerAngles.z = 0
				var_32_12.localEulerAngles.x = 0
				var_32_12.localEulerAngles = var_32_12.localEulerAngles
			end

			local var_32_14 = arg_29_1.actors_["1097ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_15 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_15 and not isNil(var_32_14) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_14) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_15)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_15 and arg_29_1.time_ < 0 + var_32_15 + arg_32_0 and not isNil(var_32_14) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_32_16 = 0
			local var_32_17 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(412041007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 32 <= 0 and var_32_17 or var_32_17 * (utf8.len(var_32_19) / 32)

				if (32 <= 0 and var_32_17 or var_32_17 * (utf8.len(var_32_19) / 32)) > 0 and var_32_17 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21

					if var_32_21 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041007", "story_v_out_412041.awb") ~= 0 then
					local var_32_22 = manager.audio:GetVoiceLength("story_v_out_412041", "412041007", "story_v_out_412041.awb") / 1000

					if var_32_22 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_16
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_412041", "412041007", "story_v_out_412041.awb")

						arg_29_1:RecordAudio("412041007", var_32_23)
						arg_29_1:RecordAudio("412041007", var_32_23)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_412041", "412041007", "story_v_out_412041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_412041", "412041007", "story_v_out_412041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_24 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_24 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_24

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_24 and arg_29_1.time_ < var_32_16 + var_32_24 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 412041008
		arg_33_1.duration_ = 9.97

		local var_33_0 = {
			zh = 9.966,
			ja = 4.2
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
				arg_33_0:Play412041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10076ui_story"]) and arg_33_1.var_.characterEffect10076ui_story == nil then
				arg_33_1.var_.characterEffect10076ui_story = arg_33_1.actors_["10076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10076ui_story"]) then
				if arg_33_1.var_.characterEffect10076ui_story and not isNil(arg_33_1.actors_["10076ui_story"]) then
					arg_33_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10076ui_story"]) and arg_33_1.var_.characterEffect10076ui_story then
				arg_33_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_36_1 = arg_33_1.actors_["10083ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10083ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10083ui_story, Vector3.New(-1, -2.6, -2.8), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(-1, -2.6, -2.8)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			local var_36_3 = arg_33_1.actors_["10083ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect10083ui_story == nil then
				arg_33_1.var_.characterEffect10083ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect10083ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect10083ui_story then
				arg_33_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action3_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_6 = arg_33_1.actors_["10076ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10076ui_story = var_36_6.localPosition
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_6.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_33_1.time_ - 0) / var_36_7)
				var_36_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_6.position).x, (manager.ui.mainCamera.transform.position - var_36_6.position).y, (manager.ui.mainCamera.transform.position - var_36_6.position).z)
				var_36_6.localEulerAngles.z = 0
				var_36_6.localEulerAngles.x = 0
				var_36_6.localEulerAngles = var_36_6.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_6.localPosition = Vector3.New(1, -0.35, -4)
				var_36_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_6.position).x, (manager.ui.mainCamera.transform.position - var_36_6.position).y, (manager.ui.mainCamera.transform.position - var_36_6.position).z)
				var_36_6.localEulerAngles.z = 0
				var_36_6.localEulerAngles.x = 0
				var_36_6.localEulerAngles = var_36_6.localEulerAngles
			end

			local var_36_8 = 0
			local var_36_9 = 0.875

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(412041008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 35 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 35)

				if (35 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 35)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041008", "story_v_out_412041.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_412041", "412041008", "story_v_out_412041.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_412041", "412041008", "story_v_out_412041.awb")

						arg_33_1:RecordAudio("412041008", var_36_15)
						arg_33_1:RecordAudio("412041008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_412041", "412041008", "story_v_out_412041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_412041", "412041008", "story_v_out_412041.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
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
	Play412041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 412041009
		arg_37_1.duration_ = 6.27

		local var_37_0 = {
			zh = 4.4,
			ja = 6.266
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
				arg_37_0:Play412041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10083ui_story"]) and arg_37_1.var_.characterEffect10083ui_story == nil then
				arg_37_1.var_.characterEffect10083ui_story = arg_37_1.actors_["10083ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10083ui_story"]) then
				if arg_37_1.var_.characterEffect10083ui_story and not isNil(arg_37_1.actors_["10083ui_story"]) then
					arg_37_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10083ui_story"]) and arg_37_1.var_.characterEffect10083ui_story then
				arg_37_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_40_1 = arg_37_1.actors_["10076ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10076ui_story == nil then
				arg_37_1.var_.characterEffect10076ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10076ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10076ui_story then
				arg_37_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_40_4 = 0
			local var_40_5 = 0.575

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(412041009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 23 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 23)

				if (23 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 23)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041009", "story_v_out_412041.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041009", "story_v_out_412041.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_412041", "412041009", "story_v_out_412041.awb")

						arg_37_1:RecordAudio("412041009", var_40_11)
						arg_37_1:RecordAudio("412041009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_412041", "412041009", "story_v_out_412041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_412041", "412041009", "story_v_out_412041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play412041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412041010
		arg_41_1.duration_ = 17.67

		local var_41_0 = {
			zh = 17.666,
			ja = 9.566
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
				arg_41_0:Play412041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10083ui_story = arg_41_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10083ui_story"].transform.position).z)
				arg_41_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10083ui_story"].transform.localEulerAngles = arg_41_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10083ui_story"].transform.position).z)
				arg_41_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10083ui_story"].transform.localEulerAngles = arg_41_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10076ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10076ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(0, 100, 0)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = arg_41_1.actors_["1097ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1097ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(0, -0.54, -6.3)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["1097ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect1097ui_story == nil then
				arg_41_1.var_.characterEffect1097ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect1097ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect1097ui_story then
				arg_41_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_44_8 = 0
			local var_44_9 = 1.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(412041010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 55 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 55)

				if (55 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 55)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041010", "story_v_out_412041.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_412041", "412041010", "story_v_out_412041.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_412041", "412041010", "story_v_out_412041.awb")

						arg_41_1:RecordAudio("412041010", var_44_15)
						arg_41_1:RecordAudio("412041010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412041", "412041010", "story_v_out_412041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412041", "412041010", "story_v_out_412041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play412041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 412041011
		arg_45_1.duration_ = 5.5

		local var_45_0 = {
			zh = 2.466,
			ja = 5.5
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play412041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(412041011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 8)

				if (8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 8)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041011", "story_v_out_412041.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_412041", "412041011", "story_v_out_412041.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_412041", "412041011", "story_v_out_412041.awb")

						arg_45_1:RecordAudio("412041011", var_48_6)
						arg_45_1:RecordAudio("412041011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_412041", "412041011", "story_v_out_412041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_412041", "412041011", "story_v_out_412041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play412041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412041012
		arg_49_1.duration_ = 10.8

		local var_49_0 = {
			zh = 10.8,
			ja = 6.833
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
				arg_49_0:Play412041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1097ui_story = arg_49_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).z)
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles = arg_49_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1097ui_story"].transform.position).z)
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1097ui_story"].transform.localEulerAngles = arg_49_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10083ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10083ui_story = var_52_1.localPosition
			end

			local var_52_2 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 then
				var_52_1.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_49_1.time_ - 0) / var_52_2)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 then
				var_52_1.localPosition = Vector3.New(0, -2.6, -2.8)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			local var_52_3 = arg_49_1.actors_["10083ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect10083ui_story == nil then
				arg_49_1.var_.characterEffect10083ui_story = var_52_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 and not isNil(var_52_3) then
				if arg_49_1.var_.characterEffect10083ui_story and not isNil(var_52_3) then
					arg_49_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect10083ui_story then
				arg_49_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_52_6 = 0
			local var_52_7 = 1.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(412041012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 51 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 51)

				if (51 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 51)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041012", "story_v_out_412041.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041012", "story_v_out_412041.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_412041", "412041012", "story_v_out_412041.awb")

						arg_49_1:RecordAudio("412041012", var_52_13)
						arg_49_1:RecordAudio("412041012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412041", "412041012", "story_v_out_412041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412041", "412041012", "story_v_out_412041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play412041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412041013
		arg_53_1.duration_ = 10.97

		local var_53_0 = {
			zh = 10.966,
			ja = 7.733
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
				arg_53_0:Play412041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(412041013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 52 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 52)

				if (52 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 52)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041013", "story_v_out_412041.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_412041", "412041013", "story_v_out_412041.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_412041", "412041013", "story_v_out_412041.awb")

						arg_53_1:RecordAudio("412041013", var_56_6)
						arg_53_1:RecordAudio("412041013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412041", "412041013", "story_v_out_412041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412041", "412041013", "story_v_out_412041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412041014
		arg_57_1.duration_ = 4.03

		local var_57_0 = {
			zh = 3.333,
			ja = 4.033
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
				arg_57_0:Play412041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1097ui_story = arg_57_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_57_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1097ui_story"].transform.position).z)
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1097ui_story"].transform.localEulerAngles = arg_57_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10083ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10083ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = arg_57_1.actors_["1097ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_60_6 = 0
			local var_60_7 = 0.225

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(412041014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 9 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 9)

				if (9 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 9)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041014", "story_v_out_412041.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041014", "story_v_out_412041.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_412041", "412041014", "story_v_out_412041.awb")

						arg_57_1:RecordAudio("412041014", var_60_13)
						arg_57_1:RecordAudio("412041014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412041", "412041014", "story_v_out_412041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412041", "412041014", "story_v_out_412041.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play412041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412041015
		arg_61_1.duration_ = 1.93

		local var_61_0 = {
			zh = 1.833,
			ja = 1.933
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
				arg_61_0:Play412041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1097ui_story"]) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = arg_61_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1097ui_story"]) then
				if arg_61_1.var_.characterEffect1097ui_story and not isNil(arg_61_1.actors_["1097ui_story"]) then
					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1097ui_story"]) and arg_61_1.var_.characterEffect1097ui_story then
				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[913].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097_sheep")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(412041015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 17 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 17)

				if (17 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 17)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041015", "story_v_out_412041.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_412041", "412041015", "story_v_out_412041.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_412041", "412041015", "story_v_out_412041.awb")

						arg_61_1:RecordAudio("412041015", var_64_8)
						arg_61_1:RecordAudio("412041015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_412041", "412041015", "story_v_out_412041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_412041", "412041015", "story_v_out_412041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play412041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412041016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play412041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.675

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(412041016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 27 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 27)

				if (27 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 27)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play412041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412041017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play412041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(412041017).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 50 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 50)

				if (50 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 50)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play412041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412041018
		arg_73_1.duration_ = 3.8

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1097ui_story = arg_73_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).z)
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles = arg_73_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1097ui_story"].transform.position).z)
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1097ui_story"].transform.localEulerAngles = arg_73_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10083ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10083ui_story = var_76_1.localPosition
			end

			local var_76_2 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 then
				var_76_1.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_73_1.time_ - 0) / var_76_2)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 then
				var_76_1.localPosition = Vector3.New(0, -2.6, -2.8)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			local var_76_3 = arg_73_1.actors_["10083ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect10083ui_story == nil then
				arg_73_1.var_.characterEffect10083ui_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect10083ui_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect10083ui_story then
				arg_73_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_76_6 = 0
			local var_76_7 = 0.475

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(412041018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 19 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 19)

				if (19 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 19)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041018", "story_v_out_412041.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041018", "story_v_out_412041.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_out_412041", "412041018", "story_v_out_412041.awb")

						arg_73_1:RecordAudio("412041018", var_76_13)
						arg_73_1:RecordAudio("412041018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412041", "412041018", "story_v_out_412041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412041", "412041018", "story_v_out_412041.awb")
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play412041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412041019
		arg_77_1.duration_ = 11.53

		local var_77_0 = {
			zh = 8.5,
			ja = 11.533
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
				arg_77_0:Play412041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10076ui_story = arg_77_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10076ui_story"].transform.position).z)
				arg_77_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10076ui_story"].transform.localEulerAngles = arg_77_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_77_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10076ui_story"].transform.position).z)
				arg_77_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10076ui_story"].transform.localEulerAngles = arg_77_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10083ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10083ui_story = var_80_1.localPosition
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			local var_80_3 = arg_77_1.actors_["10076ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect10076ui_story == nil then
				arg_77_1.var_.characterEffect10076ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect10076ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect10076ui_story then
				arg_77_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_80_6 = 0
			local var_80_7 = 1.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(412041019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 44 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 44)

				if (44 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 44)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041019", "story_v_out_412041.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041019", "story_v_out_412041.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_412041", "412041019", "story_v_out_412041.awb")

						arg_77_1:RecordAudio("412041019", var_80_13)
						arg_77_1:RecordAudio("412041019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412041", "412041019", "story_v_out_412041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412041", "412041019", "story_v_out_412041.awb")
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
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play412041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412041020
		arg_81_1.duration_ = 7.43

		local var_81_0 = {
			zh = 7.433,
			ja = 5.233
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
				arg_81_0:Play412041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.925

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(412041020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 37 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 37)

				if (37 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 37)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041020", "story_v_out_412041.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_412041", "412041020", "story_v_out_412041.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_412041", "412041020", "story_v_out_412041.awb")

						arg_81_1:RecordAudio("412041020", var_84_6)
						arg_81_1:RecordAudio("412041020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_412041", "412041020", "story_v_out_412041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_412041", "412041020", "story_v_out_412041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play412041021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412041021
		arg_85_1.duration_ = 14.2

		local var_85_0 = {
			zh = 14.2,
			ja = 8.366
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
				arg_85_0:Play412041022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10083ui_story = arg_85_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10083ui_story"].transform.position).z)
				arg_85_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10083ui_story"].transform.localEulerAngles = arg_85_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, -2.6, -2.8)
				arg_85_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10083ui_story"].transform.position).z)
				arg_85_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10083ui_story"].transform.localEulerAngles = arg_85_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10076ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10076ui_story = var_88_1.localPosition
			end

			local var_88_2 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_2)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0, 100, 0)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action3_1")
			end

			local var_88_3 = 0
			local var_88_4 = 1.475

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(412041021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 59 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 59)

				if (59 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 59)) > 0 and var_88_4 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041021", "story_v_out_412041.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_out_412041", "412041021", "story_v_out_412041.awb") / 1000

					if var_88_9 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_3
					end

					if var_88_5.prefab_name ~= "" and arg_85_1.actors_[var_88_5.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_5.prefab_name].transform, "story_v_out_412041", "412041021", "story_v_out_412041.awb")

						arg_85_1:RecordAudio("412041021", var_88_10)
						arg_85_1:RecordAudio("412041021", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412041", "412041021", "story_v_out_412041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412041", "412041021", "story_v_out_412041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_11 and arg_85_1.time_ < var_88_3 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play412041022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412041022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play412041023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:AudioAction("play", "effect", "se_story_132", "se_story_132_Weihua", "")
			end

			local var_92_1 = arg_89_1.actors_["10083ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10083ui_story == nil then
				arg_89_1.var_.characterEffect10083ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect10083ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_2)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10083ui_story then
				arg_89_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			local var_92_3 = 0
			local var_92_4 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(412041022).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 19 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 19)

				if (19 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 19)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play412041023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412041023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play412041024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10083ui_story = arg_93_1.actors_["10083ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10083ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10083ui_story"].transform.position).z)
				arg_93_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10083ui_story"].transform.localEulerAngles = arg_93_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10083ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10083ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10083ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10083ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10083ui_story"].transform.position).z)
				arg_93_1.actors_["10083ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10083ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10083ui_story"].transform.localEulerAngles = arg_93_1.actors_["10083ui_story"].transform.localEulerAngles
			end

			local var_96_1 = 0
			local var_96_2 = 0.925

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(412041023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 37 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 37)

				if (37 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 37)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play412041024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 412041024
		arg_97_1.duration_ = 5.7

		local var_97_0 = {
			zh = 2.966,
			ja = 5.7
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play412041025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1097ui_story = arg_97_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1097ui_story"].transform.position).z)
				arg_97_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1097ui_story"].transform.localEulerAngles = arg_97_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_97_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1097ui_story"].transform.position).z)
				arg_97_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1097ui_story"].transform.localEulerAngles = arg_97_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_100_1 = arg_97_1.actors_["1097ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1097ui_story == nil then
				arg_97_1.var_.characterEffect1097ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1097ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1097ui_story then
				arg_97_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.225

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(412041024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)

				if (9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041024", "story_v_out_412041.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041024", "story_v_out_412041.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_412041", "412041024", "story_v_out_412041.awb")

						arg_97_1:RecordAudio("412041024", var_100_11)
						arg_97_1:RecordAudio("412041024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_412041", "412041024", "story_v_out_412041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_412041", "412041024", "story_v_out_412041.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play412041025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 412041025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play412041026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1097ui_story"]) and arg_101_1.var_.characterEffect1097ui_story == nil then
				arg_101_1.var_.characterEffect1097ui_story = arg_101_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1097ui_story"]) then
				if arg_101_1.var_.characterEffect1097ui_story and not isNil(arg_101_1.actors_["1097ui_story"]) then
					arg_101_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1097ui_story"]) and arg_101_1.var_.characterEffect1097ui_story then
				arg_101_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(412041025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 28 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 28)

				if (28 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 28)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play412041026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 412041026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play412041027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(412041026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 59 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 59)

				if (59 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 59)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play412041027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 412041027
		arg_109_1.duration_ = 8.37

		local var_109_0 = {
			zh = 7.9,
			ja = 8.366
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
				arg_109_0:Play412041028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1097ui_story"]) and arg_109_1.var_.characterEffect1097ui_story == nil then
				arg_109_1.var_.characterEffect1097ui_story = arg_109_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1097ui_story"]) then
				if arg_109_1.var_.characterEffect1097ui_story and not isNil(arg_109_1.actors_["1097ui_story"]) then
					arg_109_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1097ui_story"]) and arg_109_1.var_.characterEffect1097ui_story then
				arg_109_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.675

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(412041027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 27 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 27)

				if (27 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 27)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041027", "story_v_out_412041.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_412041", "412041027", "story_v_out_412041.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_412041", "412041027", "story_v_out_412041.awb")

						arg_109_1:RecordAudio("412041027", var_112_9)
						arg_109_1:RecordAudio("412041027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_412041", "412041027", "story_v_out_412041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_412041", "412041027", "story_v_out_412041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play412041028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 412041028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play412041029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1097ui_story"]) and arg_113_1.var_.characterEffect1097ui_story == nil then
				arg_113_1.var_.characterEffect1097ui_story = arg_113_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1097ui_story"]) then
				if arg_113_1.var_.characterEffect1097ui_story and not isNil(arg_113_1.actors_["1097ui_story"]) then
					arg_113_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1097ui_story"]) and arg_113_1.var_.characterEffect1097ui_story then
				arg_113_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_116_1 = arg_113_1.actors_["1097ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1097ui_story = var_116_1.localPosition
			end

			local var_116_2 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 then
				var_116_1.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_2)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 then
				var_116_1.localPosition = Vector3.New(0, 100, 0)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			local var_116_3 = 0
			local var_116_4 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(412041028).content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 22 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 22)

				if (22 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 22)) > 0 and var_116_4 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_8 and arg_113_1.time_ < var_116_3 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play412041029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 412041029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play412041030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.975

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(412041029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 39 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 39)

				if (39 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 39)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play412041030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 412041030
		arg_121_1.duration_ = 7

		local var_121_0 = {
			zh = 6.066,
			ja = 7
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
				arg_121_0:Play412041031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10078ui_story"]) and arg_121_1.var_.characterEffect10078ui_story == nil then
				arg_121_1.var_.characterEffect10078ui_story = arg_121_1.actors_["10078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10078ui_story"]) then
				if arg_121_1.var_.characterEffect10078ui_story and not isNil(arg_121_1.actors_["10078ui_story"]) then
					arg_121_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10078ui_story"]) and arg_121_1.var_.characterEffect10078ui_story then
				arg_121_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_2")
			end

			local var_124_2 = arg_121_1.actors_["10078ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10078ui_story = var_124_2.localPosition
			end

			local var_124_3 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_121_1.time_ - 0) / var_124_3)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -0.5, -6.3)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(412041030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 16 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 16)

				if (16 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 16)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041030", "story_v_out_412041.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041030", "story_v_out_412041.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_412041", "412041030", "story_v_out_412041.awb")

						arg_121_1:RecordAudio("412041030", var_124_11)
						arg_121_1:RecordAudio("412041030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_412041", "412041030", "story_v_out_412041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_412041", "412041030", "story_v_out_412041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play412041031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 412041031
		arg_125_1.duration_ = 5.6

		local var_125_0 = {
			zh = 5.6,
			ja = 5
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play412041032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action3_1")
			end

			local var_128_0 = arg_125_1.actors_["10078ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10078ui_story = var_128_0.localPosition
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_1)
				var_128_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_0.position).x, (manager.ui.mainCamera.transform.position - var_128_0.position).y, (manager.ui.mainCamera.transform.position - var_128_0.position).z)
				var_128_0.localEulerAngles.z = 0
				var_128_0.localEulerAngles.x = 0
				var_128_0.localEulerAngles = var_128_0.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)
				var_128_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_0.position).x, (manager.ui.mainCamera.transform.position - var_128_0.position).y, (manager.ui.mainCamera.transform.position - var_128_0.position).z)
				var_128_0.localEulerAngles.z = 0
				var_128_0.localEulerAngles.x = 0
				var_128_0.localEulerAngles = var_128_0.localEulerAngles
			end

			local var_128_2 = arg_125_1.actors_["10083ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10083ui_story == nil then
				arg_125_1.var_.characterEffect10083ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect10083ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10083ui_story then
				arg_125_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_128_5 = arg_125_1.actors_["10083ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10083ui_story = var_128_5.localPosition
			end

			local var_128_6 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_125_1.time_ - 0) / var_128_6)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(0, -2.6, -2.8)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			local var_128_7 = 0
			local var_128_8 = 0.525

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_9 = arg_125_1:GetWordFromCfg(412041031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_12 = 21 <= 0 and var_128_8 or var_128_8 * (utf8.len(var_128_10) / 21)

				if (21 <= 0 and var_128_8 or var_128_8 * (utf8.len(var_128_10) / 21)) > 0 and var_128_8 < var_128_12 then
					arg_125_1.talkMaxDuration = var_128_12

					if var_128_12 + var_128_7 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_7
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041031", "story_v_out_412041.awb") ~= 0 then
					local var_128_13 = manager.audio:GetVoiceLength("story_v_out_412041", "412041031", "story_v_out_412041.awb") / 1000

					if var_128_13 + var_128_7 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_7
					end

					if var_128_9.prefab_name ~= "" and arg_125_1.actors_[var_128_9.prefab_name] ~= nil then
						local var_128_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_9.prefab_name].transform, "story_v_out_412041", "412041031", "story_v_out_412041.awb")

						arg_125_1:RecordAudio("412041031", var_128_14)
						arg_125_1:RecordAudio("412041031", var_128_14)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_412041", "412041031", "story_v_out_412041.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_412041", "412041031", "story_v_out_412041.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_15 = math.max(var_128_8, arg_125_1.talkMaxDuration)

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_15 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_7) / var_128_15

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_7 + var_128_15 and arg_125_1.time_ < var_128_7 + var_128_15 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play412041032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 412041032
		arg_129_1.duration_ = 5.27

		local var_129_0 = {
			zh = 5.266,
			ja = 1.533
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
				arg_129_0:Play412041033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1097ui_story = arg_129_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).z)
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles = arg_129_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_129_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1097ui_story"].transform.position).z)
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1097ui_story"].transform.localEulerAngles = arg_129_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["10083ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10083ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0, 100, 0)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			local var_132_3 = arg_129_1.actors_["1097ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect1097ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1097ui_story then
				arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_132_6 = 0
			local var_132_7 = 0.425

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(412041032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 17 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 17)

				if (17 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 17)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041032", "story_v_out_412041.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041032", "story_v_out_412041.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_412041", "412041032", "story_v_out_412041.awb")

						arg_129_1:RecordAudio("412041032", var_132_13)
						arg_129_1:RecordAudio("412041032", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_412041", "412041032", "story_v_out_412041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_412041", "412041032", "story_v_out_412041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play412041033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 412041033
		arg_133_1.duration_ = 4.27

		local var_133_0 = {
			zh = 2.466,
			ja = 4.266
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
				arg_133_0:Play412041034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1097ui_story = arg_133_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1097ui_story"].transform.position).z)
				arg_133_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1097ui_story"].transform.localEulerAngles = arg_133_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1097ui_story"].transform.position).z)
				arg_133_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1097ui_story"].transform.localEulerAngles = arg_133_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10076ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10076ui_story == nil then
				arg_133_1.var_.characterEffect10076ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10076ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10076ui_story then
				arg_133_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["10076ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10076ui_story = var_136_4.localPosition
			end

			local var_136_5 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_133_1.time_ - 0) / var_136_5)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(0, -0.35, -4)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			local var_136_6 = 0
			local var_136_7 = 0.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_8 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_8:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(412041033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_12 = 11 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_10) / 11)

				if (11 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_10) / 11)) > 0 and var_136_7 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12
					var_136_6 = var_136_6 + 0.3

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041033", "story_v_out_412041.awb") ~= 0 then
					local var_136_13 = manager.audio:GetVoiceLength("story_v_out_412041", "412041033", "story_v_out_412041.awb") / 1000

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_412041", "412041033", "story_v_out_412041.awb")

						arg_133_1:RecordAudio("412041033", var_136_14)
						arg_133_1:RecordAudio("412041033", var_136_14)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_412041", "412041033", "story_v_out_412041.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_412041", "412041033", "story_v_out_412041.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_15 = var_136_6 + 0.3
			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_15) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_15 + var_136_16 and arg_133_1.time_ < var_136_15 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play412041034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 412041034
		arg_139_1.duration_ = 4.7

		local var_139_0 = {
			zh = 4.233,
			ja = 4.7
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play412041035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 1 < arg_139_1.time_ and arg_139_1.time_ <= 1 + arg_142_0 then
				local var_142_0 = arg_139_1.bgs_.ST30

				arg_139_1.bgs_.ST30.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_142_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_1 = var_142_0:GetComponent("SpriteRenderer")

				if var_142_1 and var_142_1.sprite then
					local var_142_2 = 2 * (var_142_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_142_0.transform.localScale = Vector3.New(var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "ST30" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_3 = 2

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_3 + 0.3 and arg_139_1.time_ < var_142_3 + 0.3 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_4 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_5 = 1

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_5 then
				local var_142_6 = Color.New(0, 0, 0)

				var_142_6.a = Mathf.Lerp(0, 1, (arg_139_1.time_ - var_142_4) / var_142_5)
				arg_139_1.mask_.color = var_142_6
			end

			if arg_139_1.time_ >= var_142_4 + var_142_5 and arg_139_1.time_ < var_142_4 + var_142_5 + arg_142_0 then
				local var_142_7 = Color.New(0, 0, 0)

				var_142_7.a = 1
				arg_139_1.mask_.color = var_142_7
			end

			local var_142_8 = 1

			if 1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_9 = 1

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_9 then
				local var_142_10 = Color.New(0, 0, 0)

				var_142_10.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_8) / var_142_9)
				arg_139_1.mask_.color = var_142_10
			end

			if arg_139_1.time_ >= var_142_8 + var_142_9 and arg_139_1.time_ < var_142_8 + var_142_9 + arg_142_0 then
				local var_142_11 = Color.New(0, 0, 0)

				arg_139_1.mask_.enabled = false
				var_142_11.a = 0
				arg_139_1.mask_.color = var_142_11
			end

			local var_142_12 = arg_139_1.actors_["10076ui_story"].transform

			if 0.966 < arg_139_1.time_ and arg_139_1.time_ <= 0.966 + arg_142_0 then
				arg_139_1.var_.moveOldPos10076ui_story = var_142_12.localPosition
			end

			local var_142_13 = 0.001

			if 0.966 <= arg_139_1.time_ and arg_139_1.time_ < 0.966 + var_142_13 then
				var_142_12.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0.966) / var_142_13)
				var_142_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_12.position).x, (manager.ui.mainCamera.transform.position - var_142_12.position).y, (manager.ui.mainCamera.transform.position - var_142_12.position).z)
				var_142_12.localEulerAngles.z = 0
				var_142_12.localEulerAngles.x = 0
				var_142_12.localEulerAngles = var_142_12.localEulerAngles
			end

			if arg_139_1.time_ >= 0.966 + var_142_13 and arg_139_1.time_ < 0.966 + var_142_13 + arg_142_0 then
				var_142_12.localPosition = Vector3.New(0, 100, 0)
				var_142_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_12.position).x, (manager.ui.mainCamera.transform.position - var_142_12.position).y, (manager.ui.mainCamera.transform.position - var_142_12.position).z)
				var_142_12.localEulerAngles.z = 0
				var_142_12.localEulerAngles.x = 0
				var_142_12.localEulerAngles = var_142_12.localEulerAngles
			end

			local var_142_14 = arg_139_1.actors_["1097ui_story"].transform

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 then
				arg_139_1.var_.moveOldPos1097ui_story = var_142_14.localPosition
			end

			local var_142_15 = 0.001

			if 1.8 <= arg_139_1.time_ and arg_139_1.time_ < 1.8 + var_142_15 then
				var_142_14.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_139_1.time_ - 1.8) / var_142_15)
				var_142_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_14.position).x, (manager.ui.mainCamera.transform.position - var_142_14.position).y, (manager.ui.mainCamera.transform.position - var_142_14.position).z)
				var_142_14.localEulerAngles.z = 0
				var_142_14.localEulerAngles.x = 0
				var_142_14.localEulerAngles = var_142_14.localEulerAngles
			end

			if arg_139_1.time_ >= 1.8 + var_142_15 and arg_139_1.time_ < 1.8 + var_142_15 + arg_142_0 then
				var_142_14.localPosition = Vector3.New(0, -0.54, -6.3)
				var_142_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_14.position).x, (manager.ui.mainCamera.transform.position - var_142_14.position).y, (manager.ui.mainCamera.transform.position - var_142_14.position).z)
				var_142_14.localEulerAngles.z = 0
				var_142_14.localEulerAngles.x = 0
				var_142_14.localEulerAngles = var_142_14.localEulerAngles
			end

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 then
				arg_139_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 then
				arg_139_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_142_16 = arg_139_1.actors_["1097ui_story"]

			if 1.8 < arg_139_1.time_ and arg_139_1.time_ <= 1.8 + arg_142_0 and not isNil(var_142_16) and arg_139_1.var_.characterEffect1097ui_story == nil then
				arg_139_1.var_.characterEffect1097ui_story = var_142_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_17 = 0.2

			if 1.8 <= arg_139_1.time_ and arg_139_1.time_ < 1.8 + var_142_17 and not isNil(var_142_16) then
				if arg_139_1.var_.characterEffect1097ui_story and not isNil(var_142_16) then
					arg_139_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 1.8 + var_142_17 and arg_139_1.time_ < 1.8 + var_142_17 + arg_142_0 and not isNil(var_142_16) and arg_139_1.var_.characterEffect1097ui_story then
				arg_139_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_19 = 2
			local var_142_20 = 0.125

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_19 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_21 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_21:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_22 = arg_139_1:GetWordFromCfg(412041034)
				local var_142_23 = arg_139_1:FormatText(var_142_22.content)

				arg_139_1.text_.text = var_142_23

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_25 = 5 <= 0 and var_142_20 or var_142_20 * (utf8.len(var_142_23) / 5)

				if (5 <= 0 and var_142_20 or var_142_20 * (utf8.len(var_142_23) / 5)) > 0 and var_142_20 < var_142_25 then
					arg_139_1.talkMaxDuration = var_142_25
					var_142_19 = var_142_19 + 0.3

					if var_142_25 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_25 + var_142_19
					end
				end

				arg_139_1.text_.text = var_142_23
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041034", "story_v_out_412041.awb") ~= 0 then
					local var_142_26 = manager.audio:GetVoiceLength("story_v_out_412041", "412041034", "story_v_out_412041.awb") / 1000

					if var_142_26 + var_142_19 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_26 + var_142_19
					end

					if var_142_22.prefab_name ~= "" and arg_139_1.actors_[var_142_22.prefab_name] ~= nil then
						local var_142_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_22.prefab_name].transform, "story_v_out_412041", "412041034", "story_v_out_412041.awb")

						arg_139_1:RecordAudio("412041034", var_142_27)
						arg_139_1:RecordAudio("412041034", var_142_27)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_412041", "412041034", "story_v_out_412041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_412041", "412041034", "story_v_out_412041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_28 = var_142_19 + 0.3
			local var_142_29 = math.max(var_142_20, arg_139_1.talkMaxDuration)

			if var_142_19 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_28 + var_142_29 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_28) / var_142_29

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_28 + var_142_29 and arg_139_1.time_ < var_142_28 + var_142_29 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play412041035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 412041035
		arg_145_1.duration_ = 10.87

		local var_145_0 = {
			zh = 10.866,
			ja = 8.266
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
				arg_145_0:Play412041036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10076ui_story = arg_145_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10076ui_story, Vector3.New(1, -0.35, -4), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).z)
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles = arg_145_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(1, -0.35, -4)
				arg_145_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10076ui_story"].transform.position).z)
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10076ui_story"].transform.localEulerAngles = arg_145_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action4_1")
			end

			local var_148_1 = arg_145_1.actors_["1097ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1097ui_story == nil then
				arg_145_1.var_.characterEffect1097ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1097ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1097ui_story then
				arg_145_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_148_3 = arg_145_1.actors_["1097ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1097ui_story = var_148_3.localPosition
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_3.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_145_1.time_ - 0) / var_148_4)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			local var_148_5 = arg_145_1.actors_["10076ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect10076ui_story == nil then
				arg_145_1.var_.characterEffect10076ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.characterEffect10076ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect10076ui_story then
				arg_145_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_148_8 = 0
			local var_148_9 = 1.025

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(412041035)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 41 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 41)

				if (41 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 41)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041035", "story_v_out_412041.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_412041", "412041035", "story_v_out_412041.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_412041", "412041035", "story_v_out_412041.awb")

						arg_145_1:RecordAudio("412041035", var_148_15)
						arg_145_1:RecordAudio("412041035", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_412041", "412041035", "story_v_out_412041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_412041", "412041035", "story_v_out_412041.awb")
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
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play412041036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 412041036
		arg_149_1.duration_ = 10.3

		local var_149_0 = {
			zh = 5.4,
			ja = 10.3
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
				arg_149_0:Play412041037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1097ui_story"]) and arg_149_1.var_.characterEffect1097ui_story == nil then
				arg_149_1.var_.characterEffect1097ui_story = arg_149_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1097ui_story"]) then
				if arg_149_1.var_.characterEffect1097ui_story and not isNil(arg_149_1.actors_["1097ui_story"]) then
					arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1097ui_story"]) and arg_149_1.var_.characterEffect1097ui_story then
				arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["10076ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10076ui_story == nil then
				arg_149_1.var_.characterEffect10076ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect10076ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10076ui_story then
				arg_149_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.475

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(412041036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 19 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 19)

				if (19 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 19)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041036", "story_v_out_412041.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041036", "story_v_out_412041.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_412041", "412041036", "story_v_out_412041.awb")

						arg_149_1:RecordAudio("412041036", var_152_11)
						arg_149_1:RecordAudio("412041036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_412041", "412041036", "story_v_out_412041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_412041", "412041036", "story_v_out_412041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play412041037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 412041037
		arg_153_1.duration_ = 1.47

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play412041038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1097ui_story"]) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = arg_153_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1097ui_story"]) then
				if arg_153_1.var_.characterEffect1097ui_story and not isNil(arg_153_1.actors_["1097ui_story"]) then
					arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1097ui_story"]) and arg_153_1.var_.characterEffect1097ui_story then
				arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[913].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097_sheep")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(412041037)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 4 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 4)

				if (4 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 4)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041037", "story_v_out_412041.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_out_412041", "412041037", "story_v_out_412041.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_412041", "412041037", "story_v_out_412041.awb")

						arg_153_1:RecordAudio("412041037", var_156_8)
						arg_153_1:RecordAudio("412041037", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_412041", "412041037", "story_v_out_412041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_412041", "412041037", "story_v_out_412041.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_9 and arg_153_1.time_ < var_156_1 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play412041038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 412041038
		arg_157_1.duration_ = 9

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play412041039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.bgs_.I09j == nil then
				local var_160_0 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09j")
				var_160_0.name = "I09j"
				var_160_0.transform.parent = arg_157_1.stage_.transform
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_.I09j = var_160_0
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_1 = arg_157_1.bgs_.I09j

				arg_157_1.bgs_.I09j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_2 = var_160_1:GetComponent("SpriteRenderer")

				if var_160_2 and var_160_2.sprite then
					local var_160_3 = 2 * (var_160_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_1.transform.localScale = Vector3.New(var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "I09j" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_4 = 4

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_4 + 0.3 and arg_157_1.time_ < var_160_4 + 0.3 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_5 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_6 = 2

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 then
				local var_160_7 = Color.New(0, 0, 0)

				var_160_7.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_5) / var_160_6)
				arg_157_1.mask_.color = var_160_7
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 then
				local var_160_8 = Color.New(0, 0, 0)

				var_160_8.a = 1
				arg_157_1.mask_.color = var_160_8
			end

			local var_160_9 = 2

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_10 = 2

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_10 then
				local var_160_11 = Color.New(0, 0, 0)

				var_160_11.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_9) / var_160_10)
				arg_157_1.mask_.color = var_160_11
			end

			if arg_157_1.time_ >= var_160_9 + var_160_10 and arg_157_1.time_ < var_160_9 + var_160_10 + arg_160_0 then
				local var_160_12 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_12.a = 0
				arg_157_1.mask_.color = var_160_12
			end

			local var_160_13 = arg_157_1.actors_["1097ui_story"].transform

			if 1.966 < arg_157_1.time_ and arg_157_1.time_ <= 1.966 + arg_160_0 then
				arg_157_1.var_.moveOldPos1097ui_story = var_160_13.localPosition
			end

			local var_160_14 = 0.001

			if 1.966 <= arg_157_1.time_ and arg_157_1.time_ < 1.966 + var_160_14 then
				var_160_13.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 1.966) / var_160_14)
				var_160_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_13.position).x, (manager.ui.mainCamera.transform.position - var_160_13.position).y, (manager.ui.mainCamera.transform.position - var_160_13.position).z)
				var_160_13.localEulerAngles.z = 0
				var_160_13.localEulerAngles.x = 0
				var_160_13.localEulerAngles = var_160_13.localEulerAngles
			end

			if arg_157_1.time_ >= 1.966 + var_160_14 and arg_157_1.time_ < 1.966 + var_160_14 + arg_160_0 then
				var_160_13.localPosition = Vector3.New(0, 100, 0)
				var_160_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_13.position).x, (manager.ui.mainCamera.transform.position - var_160_13.position).y, (manager.ui.mainCamera.transform.position - var_160_13.position).z)
				var_160_13.localEulerAngles.z = 0
				var_160_13.localEulerAngles.x = 0
				var_160_13.localEulerAngles = var_160_13.localEulerAngles
			end

			local var_160_15 = arg_157_1.actors_["10076ui_story"].transform

			if 1.966 < arg_157_1.time_ and arg_157_1.time_ <= 1.966 + arg_160_0 then
				arg_157_1.var_.moveOldPos10076ui_story = var_160_15.localPosition
			end

			local var_160_16 = 0.001

			if 1.966 <= arg_157_1.time_ and arg_157_1.time_ < 1.966 + var_160_16 then
				var_160_15.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 1.966) / var_160_16)
				var_160_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_15.position).x, (manager.ui.mainCamera.transform.position - var_160_15.position).y, (manager.ui.mainCamera.transform.position - var_160_15.position).z)
				var_160_15.localEulerAngles.z = 0
				var_160_15.localEulerAngles.x = 0
				var_160_15.localEulerAngles = var_160_15.localEulerAngles
			end

			if arg_157_1.time_ >= 1.966 + var_160_16 and arg_157_1.time_ < 1.966 + var_160_16 + arg_160_0 then
				var_160_15.localPosition = Vector3.New(0, 100, 0)
				var_160_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_15.position).x, (manager.ui.mainCamera.transform.position - var_160_15.position).y, (manager.ui.mainCamera.transform.position - var_160_15.position).z)
				var_160_15.localEulerAngles.z = 0
				var_160_15.localEulerAngles.x = 0
				var_160_15.localEulerAngles = var_160_15.localEulerAngles
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_17 = 4
			local var_160_18 = 0.5

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_17 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_19 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_19:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_20 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(412041038).content)

				arg_157_1.text_.text = var_160_20

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_22 = 20 <= 0 and var_160_18 or var_160_18 * (utf8.len(var_160_20) / 20)

				if (20 <= 0 and var_160_18 or var_160_18 * (utf8.len(var_160_20) / 20)) > 0 and var_160_18 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22
					var_160_17 = var_160_17 + 0.3

					if var_160_22 + var_160_17 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_17
					end
				end

				arg_157_1.text_.text = var_160_20
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_23 = var_160_17 + 0.3
			local var_160_24 = math.max(var_160_18, arg_157_1.talkMaxDuration)

			if var_160_17 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_23) / var_160_24

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play412041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 412041039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play412041040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.7

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(412041039).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 28 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 28)

				if (28 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 28)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play412041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 412041040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play412041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.95

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(412041040).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 38 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 38)

				if (38 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 38)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play412041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 412041041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play412041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.45

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(412041041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 58 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 58)

				if (58 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 58)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play412041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 412041042
		arg_175_1.duration_ = 4.7

		local var_175_0 = {
			zh = 4.7,
			ja = 4.633
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play412041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1097ui_story = arg_175_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).z)
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles = arg_175_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_175_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1097ui_story"].transform.position).z)
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1097ui_story"].transform.localEulerAngles = arg_175_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_178_1 = arg_175_1.actors_["1097ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1097ui_story == nil then
				arg_175_1.var_.characterEffect1097ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1097ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1097ui_story then
				arg_175_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_178_4 = 0
			local var_178_5 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(412041042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 13 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 13)

				if (13 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 13)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041042", "story_v_out_412041.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041042", "story_v_out_412041.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_412041", "412041042", "story_v_out_412041.awb")

						arg_175_1:RecordAudio("412041042", var_178_11)
						arg_175_1:RecordAudio("412041042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_412041", "412041042", "story_v_out_412041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_412041", "412041042", "story_v_out_412041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play412041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 412041043
		arg_179_1.duration_ = 3.7

		local var_179_0 = {
			zh = 2.033,
			ja = 3.7
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play412041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10076ui_story = arg_179_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).z)
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles = arg_179_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_179_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10076ui_story"].transform.position).z)
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10076ui_story"].transform.localEulerAngles = arg_179_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action3_1")
			end

			local var_182_1 = arg_179_1.actors_["10076ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10076ui_story == nil then
				arg_179_1.var_.characterEffect10076ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect10076ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10076ui_story then
				arg_179_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_182_4 = arg_179_1.actors_["1097ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1097ui_story = var_182_4.localPosition
			end

			local var_182_5 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 then
				var_182_4.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_5)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 then
				var_182_4.localPosition = Vector3.New(0, 100, 0)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			local var_182_6 = 0
			local var_182_7 = 0.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(412041043)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 10 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 10)

				if (10 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 10)) > 0 and var_182_7 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041043", "story_v_out_412041.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041043", "story_v_out_412041.awb") / 1000

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_412041", "412041043", "story_v_out_412041.awb")

						arg_179_1:RecordAudio("412041043", var_182_13)
						arg_179_1:RecordAudio("412041043", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_412041", "412041043", "story_v_out_412041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_412041", "412041043", "story_v_out_412041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play412041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 412041044
		arg_183_1.duration_ = 6.1

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play412041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1097ui_story = arg_183_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).z)
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles = arg_183_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_183_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1097ui_story"].transform.position).z)
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1097ui_story"].transform.localEulerAngles = arg_183_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["10076ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10076ui_story = var_186_1.localPosition
			end

			local var_186_2 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 then
				var_186_1.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_2)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 then
				var_186_1.localPosition = Vector3.New(0, 100, 0)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_186_3 = arg_183_1.actors_["1097ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect1097ui_story == nil then
				arg_183_1.var_.characterEffect1097ui_story = var_186_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_4 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 and not isNil(var_186_3) then
				if arg_183_1.var_.characterEffect1097ui_story and not isNil(var_186_3) then
					arg_183_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 and not isNil(var_186_3) and arg_183_1.var_.characterEffect1097ui_story then
				arg_183_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_186_6 = 0
			local var_186_7 = 0.6

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(412041044)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 24 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 24)

				if (24 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 24)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041044", "story_v_out_412041.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041044", "story_v_out_412041.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_412041", "412041044", "story_v_out_412041.awb")

						arg_183_1:RecordAudio("412041044", var_186_13)
						arg_183_1:RecordAudio("412041044", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_412041", "412041044", "story_v_out_412041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_412041", "412041044", "story_v_out_412041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play412041045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 412041045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play412041046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1097ui_story = arg_187_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1097ui_story"].transform.position).z)
				arg_187_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1097ui_story"].transform.localEulerAngles = arg_187_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1097ui_story"].transform.position).z)
				arg_187_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1097ui_story"].transform.localEulerAngles = arg_187_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_190_1 = 0
			local var_190_2 = 0.875

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(412041045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 35 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 35)

				if (35 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 35)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play412041046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 412041046
		arg_191_1.duration_ = 2.7

		local var_191_0 = {
			zh = 2.466,
			ja = 2.7
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play412041047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10076ui_story = arg_191_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).z)
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles = arg_191_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_191_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10076ui_story"].transform.position).z)
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10076ui_story"].transform.localEulerAngles = arg_191_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_1")
			end

			local var_194_1 = arg_191_1.actors_["10076ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10076ui_story == nil then
				arg_191_1.var_.characterEffect10076ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect10076ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10076ui_story then
				arg_191_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_194_4 = 0
			local var_194_5 = 0.25

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(412041046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 10 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 10)

				if (10 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 10)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041046", "story_v_out_412041.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041046", "story_v_out_412041.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_412041", "412041046", "story_v_out_412041.awb")

						arg_191_1:RecordAudio("412041046", var_194_11)
						arg_191_1:RecordAudio("412041046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_412041", "412041046", "story_v_out_412041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_412041", "412041046", "story_v_out_412041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play412041047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 412041047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play412041048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10076ui_story = arg_195_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).z)
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles = arg_195_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10076ui_story"].transform.position).z)
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10076ui_story"].transform.localEulerAngles = arg_195_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			local var_198_1 = 0
			local var_198_2 = 0.9

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(412041047).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 36 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 36)

				if (36 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 36)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play412041048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 412041048
		arg_199_1.duration_ = 6.1

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play412041049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_202_0 = 1.5

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				local var_202_1, var_202_2 = math.modf((arg_199_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_202_2 * 0.13, var_202_2 * 0.13, var_202_2 * 0.13) + arg_199_1.var_.shakeOldPos
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				manager.ui.mainCamera.transform.localPosition = arg_199_1.var_.shakeOldPos
			end

			local var_202_3 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			if arg_199_1.time_ >= var_202_3 + 1.5 and arg_199_1.time_ < var_202_3 + 1.5 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			if 0.866666666666667 < arg_199_1.time_ and arg_199_1.time_ <= 0.866666666666667 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_5 = 1.1
			local var_202_6 = 0.9

			if 1.1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_7 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_7:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(412041048).content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 36 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 36)

				if (36 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 36)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10
					var_202_5 = var_202_5 + 0.3

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_11 = var_202_5 + 0.3
			local var_202_12 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_11 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_11) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_11 + var_202_12 and arg_199_1.time_ < var_202_11 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play412041049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 412041049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play412041050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.475

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(412041049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 19 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 19)

				if (19 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 19)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play412041050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 412041050
		arg_209_1.duration_ = 4.43

		local var_209_0 = {
			zh = 2.633,
			ja = 4.433
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play412041051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10076ui_story = arg_209_1.actors_["10076ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["10076ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10076ui_story"].transform.position).z)
				arg_209_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["10076ui_story"].transform.localEulerAngles = arg_209_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["10076ui_story"].transform.localPosition = Vector3.New(0, -0.35, -4)
				arg_209_1.actors_["10076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["10076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10076ui_story"].transform.position).z)
				arg_209_1.actors_["10076ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["10076ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["10076ui_story"].transform.localEulerAngles = arg_209_1.actors_["10076ui_story"].transform.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action2_2")
			end

			local var_212_1 = arg_209_1.actors_["10076ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect10076ui_story == nil then
				arg_209_1.var_.characterEffect10076ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect10076ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect10076ui_story then
				arg_209_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			local var_212_4 = 0
			local var_212_5 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(412041050)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 12 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 12)

				if (12 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 12)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041050", "story_v_out_412041.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_412041", "412041050", "story_v_out_412041.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_412041", "412041050", "story_v_out_412041.awb")

						arg_209_1:RecordAudio("412041050", var_212_11)
						arg_209_1:RecordAudio("412041050", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_412041", "412041050", "story_v_out_412041.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_412041", "412041050", "story_v_out_412041.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play412041051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 412041051
		arg_213_1.duration_ = 5.97

		local var_213_0 = {
			zh = 3.666,
			ja = 5.966
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
			arg_213_1.auto_ = false
		end

		function arg_213_1.playNext_(arg_215_0)
			arg_213_1.onStoryFinished_()
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1097ui_story = arg_213_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1097ui_story"].transform.position).z)
				arg_213_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1097ui_story"].transform.localEulerAngles = arg_213_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_213_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1097ui_story"].transform.position).z)
				arg_213_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1097ui_story"].transform.localEulerAngles = arg_213_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1097ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1097ui_story == nil then
				arg_213_1.var_.characterEffect1097ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1097ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1097ui_story then
				arg_213_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["10076ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10076ui_story = var_216_4.localPosition
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_4.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_5)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_4.localPosition = Vector3.New(0, 100, 0)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_216_6 = 0
			local var_216_7 = 0.35

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:GetWordFromCfg(412041051)
				local var_216_9 = arg_213_1:FormatText(var_216_8.content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 14 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 14)

				if (14 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 14)) > 0 and var_216_7 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412041", "412041051", "story_v_out_412041.awb") ~= 0 then
					local var_216_12 = manager.audio:GetVoiceLength("story_v_out_412041", "412041051", "story_v_out_412041.awb") / 1000

					if var_216_12 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_6
					end

					if var_216_8.prefab_name ~= "" and arg_213_1.actors_[var_216_8.prefab_name] ~= nil then
						local var_216_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_8.prefab_name].transform, "story_v_out_412041", "412041051", "story_v_out_412041.awb")

						arg_213_1:RecordAudio("412041051", var_216_13)
						arg_213_1:RecordAudio("412041051", var_216_13)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_412041", "412041051", "story_v_out_412041.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_412041", "412041051", "story_v_out_412041.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST30",
		"TextureConfig/Background/I09j"
	},
	voices = {
		"story_v_out_412041.awb"
	}
}
