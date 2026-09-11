return {
	Play910601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910601001
		arg_1_1.duration_ = 7.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
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

			local var_4_8 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1084ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_12.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.97, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1084ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_4_17 = 0

			arg_1_1.isInRecall_ = false

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_18 = 2

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_17) / var_4_18)
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 2
			local var_4_23 = 0.825

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_25 = arg_1_1:GetWordFromCfg(910601001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 33 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 33)

				if (33 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 33)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601001", "story_v_out_910601.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_910601", "910601001", "story_v_out_910601.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_910601", "910601001", "story_v_out_910601.awb")

						arg_1_1:RecordAudio("910601001", var_4_30)
						arg_1_1:RecordAudio("910601001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_910601", "910601001", "story_v_out_910601.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_910601", "910601001", "story_v_out_910601.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play910601002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 910601002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play910601003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = arg_8_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(arg_8_1.actors_["1084ui_story"]) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.65

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(910601002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 26 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 26)

				if (26 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 26)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play910601003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 910601003
		arg_12_1.duration_ = 5.03

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play910601004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1011ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1011ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1011ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1011ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1011ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1011ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1011ui_story == nil then
				arg_12_1.var_.characterEffect1011ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1011ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1011ui_story then
				arg_12_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_15_8 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_8.localPosition
			end

			local var_15_9 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_12_1.time_ - 0) / var_15_9)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			local var_15_10 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_10) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_11 and not isNil(var_15_10) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_10) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_11)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_11 and arg_12_1.time_ < 0 + var_15_11 + arg_15_0 and not isNil(var_15_10) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_15_12 = 0
			local var_15_13 = 0.725

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:GetWordFromCfg(910601003)
				local var_15_15 = arg_12_1:FormatText(var_15_14.content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 29 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 29)

				if (29 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 29)) > 0 and var_15_13 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601003", "story_v_out_910601.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601003", "story_v_out_910601.awb") / 1000

					if var_15_18 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_12
					end

					if var_15_14.prefab_name ~= "" and arg_12_1.actors_[var_15_14.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_14.prefab_name].transform, "story_v_out_910601", "910601003", "story_v_out_910601.awb")

						arg_12_1:RecordAudio("910601003", var_15_19)
						arg_12_1:RecordAudio("910601003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_910601", "910601003", "story_v_out_910601.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_910601", "910601003", "story_v_out_910601.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_12) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_12 + var_15_20 and arg_12_1.time_ < var_15_12 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play910601004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 910601004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play910601005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1011ui_story"]) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = arg_16_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1011ui_story"]) then
				if arg_16_1.var_.characterEffect1011ui_story and not isNil(arg_16_1.actors_["1011ui_story"]) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1011ui_story"]) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(910601004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 26 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 26)

				if (26 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 26)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play910601005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 910601005
		arg_20_1.duration_ = 7.53

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play910601006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1048ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1048ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1048ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1048ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1048ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1048ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1048ui_story = var_23_3.localPosition

				arg_20_1:ShowWeapon(arg_20_1.var_["1048ui_story" .. "Animator"].transform, false)
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			local var_23_5 = arg_20_1.actors_["1048ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1048ui_story == nil then
				arg_20_1.var_.characterEffect1048ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1048ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1048ui_story then
				arg_20_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_8 = arg_20_1.actors_["1011ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1011ui_story = var_23_8.localPosition
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, 100, 0)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			local var_23_10 = arg_20_1.actors_["1011ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 and not isNil(var_23_10) then
				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_10) then
					arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_11)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect1011ui_story then
				arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_23_12 = arg_20_1.actors_["1084ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_12.localPosition
			end

			local var_23_13 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_13 then
				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_13)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_13 and arg_20_1.time_ < 0 + var_23_13 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(0, 100, 0)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles
			end

			local var_23_14 = arg_20_1.actors_["1084ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_15 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_15 and not isNil(var_23_14) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_15)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_15 and arg_20_1.time_ < 0 + var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_23_16 = 0
			local var_23_17 = 0.875

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(910601005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 35 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 35)

				if (35 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 35)) > 0 and var_23_17 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601005", "story_v_out_910601.awb") ~= 0 then
					local var_23_22 = manager.audio:GetVoiceLength("story_v_out_910601", "910601005", "story_v_out_910601.awb") / 1000

					if var_23_22 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_16
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_910601", "910601005", "story_v_out_910601.awb")

						arg_20_1:RecordAudio("910601005", var_23_23)
						arg_20_1:RecordAudio("910601005", var_23_23)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_910601", "910601005", "story_v_out_910601.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_910601", "910601005", "story_v_out_910601.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 <= arg_20_1.time_ and arg_20_1.time_ < var_23_16 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_16) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_16 + var_23_24 and arg_20_1.time_ < var_23_16 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play910601006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 910601006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play910601007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1048ui_story"]) and arg_24_1.var_.characterEffect1048ui_story == nil then
				arg_24_1.var_.characterEffect1048ui_story = arg_24_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1048ui_story"]) then
				if arg_24_1.var_.characterEffect1048ui_story and not isNil(arg_24_1.actors_["1048ui_story"]) then
					arg_24_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1048ui_story"]) and arg_24_1.var_.characterEffect1048ui_story then
				arg_24_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.425

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(910601006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 17 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 17)

				if (17 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 17)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play910601007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 910601007
		arg_28_1.duration_ = 9.47

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play910601008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1019ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1019ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1019ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1019ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			local var_31_5 = arg_28_1.actors_["1019ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_8 = arg_28_1.actors_["1048ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1048ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			local var_31_10 = arg_28_1.actors_["1048ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect1048ui_story == nil then
				arg_28_1.var_.characterEffect1048ui_story = var_31_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_11 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_11 and not isNil(var_31_10) then
				if arg_28_1.var_.characterEffect1048ui_story and not isNil(var_31_10) then
					arg_28_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_11)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_11 and arg_28_1.time_ < 0 + var_31_11 + arg_31_0 and not isNil(var_31_10) and arg_28_1.var_.characterEffect1048ui_story then
				arg_28_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_31_12 = 0
			local var_31_13 = 1.05

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(910601007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 42 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 42)

				if (42 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 42)) > 0 and var_31_13 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601007", "story_v_out_910601.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601007", "story_v_out_910601.awb") / 1000

					if var_31_18 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_12
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_910601", "910601007", "story_v_out_910601.awb")

						arg_28_1:RecordAudio("910601007", var_31_19)
						arg_28_1:RecordAudio("910601007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_910601", "910601007", "story_v_out_910601.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_910601", "910601007", "story_v_out_910601.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play910601008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 910601008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play910601009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1019ui_story"]) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = arg_32_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1019ui_story"]) then
				if arg_32_1.var_.characterEffect1019ui_story and not isNil(arg_32_1.actors_["1019ui_story"]) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1019ui_story"]) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.45

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(910601008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 18 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 18)

				if (18 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 18)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play910601009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 910601009
		arg_36_1.duration_ = 9

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play910601010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.bgs_.STwhite == nil then
				local var_39_0 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_39_0.name = "STwhite"
				var_39_0.transform.parent = arg_36_1.stage_.transform
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_.STwhite = var_39_0
			end

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				local var_39_1 = arg_36_1.bgs_.STwhite

				arg_36_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_39_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_2 = var_39_1:GetComponent("SpriteRenderer")

				if var_39_2 and var_39_2.sprite then
					local var_39_3 = 2 * (var_39_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_39_1.transform.localScale = Vector3.New(var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "STwhite" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_4 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_5 = 2

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_5 then
				local var_39_6 = Color.New(0, 0, 0)

				var_39_6.a = Mathf.Lerp(0, 1, (arg_36_1.time_ - var_39_4) / var_39_5)
				arg_36_1.mask_.color = var_39_6
			end

			if arg_36_1.time_ >= var_39_4 + var_39_5 and arg_36_1.time_ < var_39_4 + var_39_5 + arg_39_0 then
				local var_39_7 = Color.New(0, 0, 0)

				var_39_7.a = 1
				arg_36_1.mask_.color = var_39_7
			end

			local var_39_8 = 2

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_9 = 2

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_9 then
				local var_39_10 = Color.New(0, 0, 0)

				var_39_10.a = Mathf.Lerp(1, 0, (arg_36_1.time_ - var_39_8) / var_39_9)
				arg_36_1.mask_.color = var_39_10
			end

			if arg_36_1.time_ >= var_39_8 + var_39_9 and arg_36_1.time_ < var_39_8 + var_39_9 + arg_39_0 then
				local var_39_11 = Color.New(0, 0, 0)

				arg_36_1.mask_.enabled = false
				var_39_11.a = 0
				arg_36_1.mask_.color = var_39_11
			end

			local var_39_12 = arg_36_1.actors_["1019ui_story"].transform

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_12.localPosition
			end

			local var_39_13 = 0.001

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_13 then
				var_39_12.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 2) / var_39_13)
				var_39_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_12.position).x, (manager.ui.mainCamera.transform.position - var_39_12.position).y, (manager.ui.mainCamera.transform.position - var_39_12.position).z)
				var_39_12.localEulerAngles.z = 0
				var_39_12.localEulerAngles.x = 0
				var_39_12.localEulerAngles = var_39_12.localEulerAngles
			end

			if arg_36_1.time_ >= 2 + var_39_13 and arg_36_1.time_ < 2 + var_39_13 + arg_39_0 then
				var_39_12.localPosition = Vector3.New(0, 100, 0)
				var_39_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_12.position).x, (manager.ui.mainCamera.transform.position - var_39_12.position).y, (manager.ui.mainCamera.transform.position - var_39_12.position).z)
				var_39_12.localEulerAngles.z = 0
				var_39_12.localEulerAngles.x = 0
				var_39_12.localEulerAngles = var_39_12.localEulerAngles
			end

			local var_39_14 = arg_36_1.actors_["1019ui_story"]

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_15 = 0.200000002980232

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_15 and not isNil(var_39_14) then
				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_14) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 2) / var_39_15)
				end
			end

			if arg_36_1.time_ >= 2 + var_39_15 and arg_36_1.time_ < 2 + var_39_15 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_39_16 = arg_36_1.actors_["1048ui_story"].transform

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 then
				arg_36_1.var_.moveOldPos1048ui_story = var_39_16.localPosition
			end

			local var_39_17 = 0.001

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_17 then
				var_39_16.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 2) / var_39_17)
				var_39_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_16.position).x, (manager.ui.mainCamera.transform.position - var_39_16.position).y, (manager.ui.mainCamera.transform.position - var_39_16.position).z)
				var_39_16.localEulerAngles.z = 0
				var_39_16.localEulerAngles.x = 0
				var_39_16.localEulerAngles = var_39_16.localEulerAngles
			end

			if arg_36_1.time_ >= 2 + var_39_17 and arg_36_1.time_ < 2 + var_39_17 + arg_39_0 then
				var_39_16.localPosition = Vector3.New(0, 100, 0)
				var_39_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_16.position).x, (manager.ui.mainCamera.transform.position - var_39_16.position).y, (manager.ui.mainCamera.transform.position - var_39_16.position).z)
				var_39_16.localEulerAngles.z = 0
				var_39_16.localEulerAngles.x = 0
				var_39_16.localEulerAngles = var_39_16.localEulerAngles
			end

			local var_39_18 = arg_36_1.actors_["1048ui_story"]

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= 2 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect1048ui_story == nil then
				arg_36_1.var_.characterEffect1048ui_story = var_39_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_19 = 0.200000002980232

			if 2 <= arg_36_1.time_ and arg_36_1.time_ < 2 + var_39_19 and not isNil(var_39_18) then
				if arg_36_1.var_.characterEffect1048ui_story and not isNil(var_39_18) then
					arg_36_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 2) / var_39_19)
				end
			end

			if arg_36_1.time_ >= 2 + var_39_19 and arg_36_1.time_ < 2 + var_39_19 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect1048ui_story then
				arg_36_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_39_20 = 2

			arg_36_1.isInRecall_ = false

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.screenFilterGo_:SetActive(false)

				for iter_39_2, iter_39_3 in pairs(arg_36_1.actors_) do
					for iter_39_4, iter_39_5 in ipairs((iter_39_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_39_5.color = iter_39_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_39_21 = 0.0166666666666667

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				arg_36_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_36_1.time_ - var_39_20) / var_39_21)
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				arg_36_1.screenFilterEffect_.weight = 0
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_22 = 4
			local var_39_23 = 0.05

			if 4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_22 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_24 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_24:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_25 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(910601009).content)

				arg_36_1.text_.text = var_39_25

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_27 = 2 <= 0 and var_39_23 or var_39_23 * (utf8.len(var_39_25) / 2)

				if (2 <= 0 and var_39_23 or var_39_23 * (utf8.len(var_39_25) / 2)) > 0 and var_39_23 < var_39_27 then
					arg_36_1.talkMaxDuration = var_39_27
					var_39_22 = var_39_22 + 0.3

					if var_39_27 + var_39_22 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_27 + var_39_22
					end
				end

				arg_36_1.text_.text = var_39_25
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_28 = var_39_22 + 0.3
			local var_39_29 = math.max(var_39_23, arg_36_1.talkMaxDuration)

			if var_39_22 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_28 + var_39_29 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_28) / var_39_29

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_28 + var_39_29 and arg_36_1.time_ < var_39_28 + var_39_29 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play910601010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 910601010
		arg_42_1.duration_ = 9

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play910601011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 2 < arg_42_1.time_ and arg_42_1.time_ <= 2 + arg_45_0 then
				local var_45_0 = arg_42_1.bgs_.B13

				arg_42_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_45_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_1 = var_45_0:GetComponent("SpriteRenderer")

				if var_45_1 and var_45_1.sprite then
					local var_45_2 = 2 * (var_45_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_45_0.transform.localScale = Vector3.New(var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "B13" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_3 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_4 = 2

			if var_45_3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_3 + var_45_4 then
				local var_45_5 = Color.New(0, 0, 0)

				var_45_5.a = Mathf.Lerp(0, 1, (arg_42_1.time_ - var_45_3) / var_45_4)
				arg_42_1.mask_.color = var_45_5
			end

			if arg_42_1.time_ >= var_45_3 + var_45_4 and arg_42_1.time_ < var_45_3 + var_45_4 + arg_45_0 then
				local var_45_6 = Color.New(0, 0, 0)

				var_45_6.a = 1
				arg_42_1.mask_.color = var_45_6
			end

			local var_45_7 = 2

			if 2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_7 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_8 = 2

			if var_45_7 <= arg_42_1.time_ and arg_42_1.time_ < var_45_7 + var_45_8 then
				local var_45_9 = Color.New(0, 0, 0)

				var_45_9.a = Mathf.Lerp(1, 0, (arg_42_1.time_ - var_45_7) / var_45_8)
				arg_42_1.mask_.color = var_45_9
			end

			if arg_42_1.time_ >= var_45_7 + var_45_8 and arg_42_1.time_ < var_45_7 + var_45_8 + arg_45_0 then
				local var_45_10 = Color.New(0, 0, 0)

				arg_42_1.mask_.enabled = false
				var_45_10.a = 0
				arg_42_1.mask_.color = var_45_10
			end

			local var_45_11 = manager.ui.mainCamera.transform

			if 3.99999999999933 < arg_42_1.time_ and arg_42_1.time_ <= 3.99999999999933 + arg_45_0 then
				arg_42_1.var_.shakeOldPos = var_45_11.localPosition
			end

			local var_45_12 = 1.133333333334

			if 3.99999999999933 <= arg_42_1.time_ and arg_42_1.time_ < 3.99999999999933 + var_45_12 then
				local var_45_13, var_45_14 = math.modf((arg_42_1.time_ - 3.99999999999933) / 0.066)

				var_45_11.localPosition = Vector3.New(var_45_14 * 0.13, var_45_14 * 0.13, var_45_14 * 0.13) + arg_42_1.var_.shakeOldPos
			end

			if arg_42_1.time_ >= 3.99999999999933 + var_45_12 and arg_42_1.time_ < 3.99999999999933 + var_45_12 + arg_45_0 then
				var_45_11.localPosition = arg_42_1.var_.shakeOldPos
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_45_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_17 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_17

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_17
						arg_42_1.bgmTxt2_.text = var_45_17
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_42_1.time_ and arg_42_1.time_ <= 0.8 + arg_45_0 then
				arg_42_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_45_20 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_42_1.bgmTxt_.text ~= var_45_20 and arg_42_1.bgmTxt_.text ~= "" then
						if arg_42_1.bgmTxt2_.text ~= "" then
							arg_42_1.bgmTxt_.text = arg_42_1.bgmTxt2_.text
						end

						arg_42_1.bgmTxt2_.text = var_45_20

						arg_42_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_42_1.bgmTxt_.text = var_45_20
						arg_42_1.bgmTxt2_.text = var_45_20
					end

					if arg_42_1.bgmTimer then
						arg_42_1.bgmTimer:Stop()

						arg_42_1.bgmTimer = nil
					end

					if arg_42_1.settingData.show_music_name == 1 then
						arg_42_1.musicController:SetSelectedState("show")
						arg_42_1.musicAnimator_:Play("open", 0, 0)

						if arg_42_1.settingData.music_time ~= 0 then
							arg_42_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_42_1.settingData.music_time), function()
								if arg_42_1 == nil or isNil(arg_42_1.bgmTxt_) then
									return
								end

								arg_42_1.musicController:SetSelectedState("hide")
								arg_42_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_21 = 4
			local var_45_22 = 0.3

			if 4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_23 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_23:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_42_1.dialogCg_.alpha = arg_48_0
				end))
				var_45_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_24 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(910601010).content)

				arg_42_1.text_.text = var_45_24

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_26 = 12 <= 0 and var_45_22 or var_45_22 * (utf8.len(var_45_24) / 12)

				if (12 <= 0 and var_45_22 or var_45_22 * (utf8.len(var_45_24) / 12)) > 0 and var_45_22 < var_45_26 then
					arg_42_1.talkMaxDuration = var_45_26
					var_45_21 = var_45_21 + 0.3

					if var_45_26 + var_45_21 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_26 + var_45_21
					end
				end

				arg_42_1.text_.text = var_45_24
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_27 = var_45_21 + 0.3
			local var_45_28 = math.max(var_45_22, arg_42_1.talkMaxDuration)

			if var_45_21 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_27 + var_45_28 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_27) / var_45_28

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_27 + var_45_28 and arg_42_1.time_ < var_45_27 + var_45_28 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play910601011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 910601011
		arg_50_1.duration_ = 5.77

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play910601012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1084ui_story = arg_50_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1084ui_story"].transform.position).z)
				arg_50_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1084ui_story"].transform.localEulerAngles = arg_50_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_50_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1084ui_story"].transform.position).z)
				arg_50_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1084ui_story"].transform.localEulerAngles = arg_50_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["1084ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1084ui_story == nil then
				arg_50_1.var_.characterEffect1084ui_story = var_53_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 and not isNil(var_53_1) then
				if arg_50_1.var_.characterEffect1084ui_story and not isNil(var_53_1) then
					arg_50_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1084ui_story then
				arg_50_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_53_4 = 0
			local var_53_5 = 0.775

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(910601011)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 31 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 31)

				if (31 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 31)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601011", "story_v_out_910601.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601011", "story_v_out_910601.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_910601", "910601011", "story_v_out_910601.awb")

						arg_50_1:RecordAudio("910601011", var_53_11)
						arg_50_1:RecordAudio("910601011", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_910601", "910601011", "story_v_out_910601.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_910601", "910601011", "story_v_out_910601.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play910601012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 910601012
		arg_54_1.duration_ = 2.93

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play910601013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1011ui_story = arg_54_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).z)
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles = arg_54_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_54_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).z)
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles = arg_54_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["1011ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1011ui_story == nil then
				arg_54_1.var_.characterEffect1011ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect1011ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1011ui_story then
				arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_57_4 = arg_54_1.actors_["1084ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1084ui_story = var_57_4.localPosition
			end

			local var_57_5 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_5 then
				var_57_4.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_54_1.time_ - 0) / var_57_5)
				var_57_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_4.position).x, (manager.ui.mainCamera.transform.position - var_57_4.position).y, (manager.ui.mainCamera.transform.position - var_57_4.position).z)
				var_57_4.localEulerAngles.z = 0
				var_57_4.localEulerAngles.x = 0
				var_57_4.localEulerAngles = var_57_4.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_5 and arg_54_1.time_ < 0 + var_57_5 + arg_57_0 then
				var_57_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_57_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_4.position).x, (manager.ui.mainCamera.transform.position - var_57_4.position).y, (manager.ui.mainCamera.transform.position - var_57_4.position).z)
				var_57_4.localEulerAngles.z = 0
				var_57_4.localEulerAngles.x = 0
				var_57_4.localEulerAngles = var_57_4.localEulerAngles
			end

			local var_57_6 = arg_54_1.actors_["1084ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_6) and arg_54_1.var_.characterEffect1084ui_story == nil then
				arg_54_1.var_.characterEffect1084ui_story = var_57_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_7 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 and not isNil(var_57_6) then
				if arg_54_1.var_.characterEffect1084ui_story and not isNil(var_57_6) then
					arg_54_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_7)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 and not isNil(var_57_6) and arg_54_1.var_.characterEffect1084ui_story then
				arg_54_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_57_8 = 0
			local var_57_9 = 0.3

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_10 = arg_54_1:GetWordFromCfg(910601012)
				local var_57_11 = arg_54_1:FormatText(var_57_10.content)

				arg_54_1.text_.text = var_57_11

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 12 <= 0 and var_57_9 or var_57_9 * (utf8.len(var_57_11) / 12)

				if (12 <= 0 and var_57_9 or var_57_9 * (utf8.len(var_57_11) / 12)) > 0 and var_57_9 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_11
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601012", "story_v_out_910601.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601012", "story_v_out_910601.awb") / 1000

					if var_57_14 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_8
					end

					if var_57_10.prefab_name ~= "" and arg_54_1.actors_[var_57_10.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_10.prefab_name].transform, "story_v_out_910601", "910601012", "story_v_out_910601.awb")

						arg_54_1:RecordAudio("910601012", var_57_15)
						arg_54_1:RecordAudio("910601012", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_910601", "910601012", "story_v_out_910601.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_910601", "910601012", "story_v_out_910601.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_16 and arg_54_1.time_ < var_57_8 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play910601013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 910601013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play910601014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1011ui_story"]) and arg_58_1.var_.characterEffect1011ui_story == nil then
				arg_58_1.var_.characterEffect1011ui_story = arg_58_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1011ui_story"]) then
				if arg_58_1.var_.characterEffect1011ui_story and not isNil(arg_58_1.actors_["1011ui_story"]) then
					arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1011ui_story"]) and arg_58_1.var_.characterEffect1011ui_story then
				arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.65

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(910601013).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 26 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 26)

				if (26 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 26)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play910601014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 910601014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play910601015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1011ui_story = arg_62_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1011ui_story"].transform.position).z)
				arg_62_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1011ui_story"].transform.localEulerAngles = arg_62_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1011ui_story"].transform.position).z)
				arg_62_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1011ui_story"].transform.localEulerAngles = arg_62_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["1011ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1011ui_story == nil then
				arg_62_1.var_.characterEffect1011ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect1011ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_2)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1011ui_story then
				arg_62_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_65_3 = arg_62_1.actors_["1084ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1084ui_story = var_65_3.localPosition
			end

			local var_65_4 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				var_65_3.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_4)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				var_65_3.localPosition = Vector3.New(0, 100, 0)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			local var_65_5 = arg_62_1.actors_["1084ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1084ui_story == nil then
				arg_62_1.var_.characterEffect1084ui_story = var_65_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_6 and not isNil(var_65_5) then
				if arg_62_1.var_.characterEffect1084ui_story and not isNil(var_65_5) then
					arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_6)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_6 and arg_62_1.time_ < 0 + var_65_6 + arg_65_0 and not isNil(var_65_5) and arg_62_1.var_.characterEffect1084ui_story then
				arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_65_7 = 0
			local var_65_8 = 1.225

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(910601014).content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 49 <= 0 and var_65_8 or var_65_8 * (utf8.len(var_65_9) / 49)

				if (49 <= 0 and var_65_8 or var_65_8 * (utf8.len(var_65_9) / 49)) > 0 and var_65_8 < var_65_11 then
					arg_62_1.talkMaxDuration = var_65_11

					if var_65_11 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_7
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_7) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_7 + var_65_12 and arg_62_1.time_ < var_65_7 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play910601015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 910601015
		arg_66_1.duration_ = 3.5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play910601016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_69_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_66_1.stage_.transform)

				var_69_0.name = "1059ui_story"
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1059ui_story"] = var_69_0

				local var_69_1 = var_69_0:GetComponentInChildren(typeof(CharacterEffect))

				var_69_1.enabled = true

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_1.transform, false)

				arg_66_1.var_["1059ui_story" .. "Animator"] = var_69_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_66_1.var_["1059ui_story" .. "LipSync"] = var_69_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_3 = arg_66_1.actors_["1059ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = var_69_3.localPosition
			end

			local var_69_4 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				var_69_3.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_66_1.time_ - 0) / var_69_4)
				var_69_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_3.position).x, (manager.ui.mainCamera.transform.position - var_69_3.position).y, (manager.ui.mainCamera.transform.position - var_69_3.position).z)
				var_69_3.localEulerAngles.z = 0
				var_69_3.localEulerAngles.x = 0
				var_69_3.localEulerAngles = var_69_3.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				var_69_3.localPosition = Vector3.New(0, -1.05, -6)
				var_69_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_3.position).x, (manager.ui.mainCamera.transform.position - var_69_3.position).y, (manager.ui.mainCamera.transform.position - var_69_3.position).z)
				var_69_3.localEulerAngles.z = 0
				var_69_3.localEulerAngles.x = 0
				var_69_3.localEulerAngles = var_69_3.localEulerAngles
			end

			local var_69_5 = arg_66_1.actors_["1059ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1059ui_story == nil then
				arg_66_1.var_.characterEffect1059ui_story = var_69_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_6 and not isNil(var_69_5) then
				if arg_66_1.var_.characterEffect1059ui_story and not isNil(var_69_5) then
					arg_66_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_6 and arg_66_1.time_ < 0 + var_69_6 + arg_69_0 and not isNil(var_69_5) and arg_66_1.var_.characterEffect1059ui_story then
				arg_66_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_69_8 = 0
			local var_69_9 = 0.45

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_10 = arg_66_1:GetWordFromCfg(910601015)
				local var_69_11 = arg_66_1:FormatText(var_69_10.content)

				arg_66_1.text_.text = var_69_11

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 18 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_11) / 18)

				if (18 <= 0 and var_69_9 or var_69_9 * (utf8.len(var_69_11) / 18)) > 0 and var_69_9 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_11
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601015", "story_v_out_910601.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601015", "story_v_out_910601.awb") / 1000

					if var_69_14 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_8
					end

					if var_69_10.prefab_name ~= "" and arg_66_1.actors_[var_69_10.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_10.prefab_name].transform, "story_v_out_910601", "910601015", "story_v_out_910601.awb")

						arg_66_1:RecordAudio("910601015", var_69_15)
						arg_66_1:RecordAudio("910601015", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_910601", "910601015", "story_v_out_910601.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_910601", "910601015", "story_v_out_910601.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_16 and arg_66_1.time_ < var_69_8 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play910601016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 910601016
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play910601017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_70_1.stage_.transform)

				var_73_0.name = "1028ui_story"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1028ui_story"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["1028ui_story" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["1028ui_story" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_3 = arg_70_1.actors_["1028ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1028ui_story = var_73_3.localPosition

				arg_70_1:ShowWeapon(arg_70_1.var_["1028ui_story" .. "Animator"].transform, false)
			end

			local var_73_4 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_3.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_70_1.time_ - 0) / var_73_4)
				var_73_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_3.position).x, (manager.ui.mainCamera.transform.position - var_73_3.position).y, (manager.ui.mainCamera.transform.position - var_73_3.position).z)
				var_73_3.localEulerAngles.z = 0
				var_73_3.localEulerAngles.x = 0
				var_73_3.localEulerAngles = var_73_3.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_3.localPosition = Vector3.New(0, -0.9, -5.9)
				var_73_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_3.position).x, (manager.ui.mainCamera.transform.position - var_73_3.position).y, (manager.ui.mainCamera.transform.position - var_73_3.position).z)
				var_73_3.localEulerAngles.z = 0
				var_73_3.localEulerAngles.x = 0
				var_73_3.localEulerAngles = var_73_3.localEulerAngles
			end

			local var_73_5 = arg_70_1.actors_["1028ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1028ui_story == nil then
				arg_70_1.var_.characterEffect1028ui_story = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_6 and not isNil(var_73_5) then
				if arg_70_1.var_.characterEffect1028ui_story and not isNil(var_73_5) then
					arg_70_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_6 and arg_70_1.time_ < 0 + var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1028ui_story then
				arg_70_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_73_8 = arg_70_1.actors_["1059ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1059ui_story = var_73_8.localPosition
			end

			local var_73_9 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_9 then
				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_9)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_9 and arg_70_1.time_ < 0 + var_73_9 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0, 100, 0)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			local var_73_10 = arg_70_1.actors_["1059ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_10) and arg_70_1.var_.characterEffect1059ui_story == nil then
				arg_70_1.var_.characterEffect1059ui_story = var_73_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_11 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_11 and not isNil(var_73_10) then
				if arg_70_1.var_.characterEffect1059ui_story and not isNil(var_73_10) then
					arg_70_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_11)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_11 and arg_70_1.time_ < 0 + var_73_11 + arg_73_0 and not isNil(var_73_10) and arg_70_1.var_.characterEffect1059ui_story then
				arg_70_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_73_12 = 0
			local var_73_13 = 0.225

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(910601016)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 9 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 9)

				if (9 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 9)) > 0 and var_73_13 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17

					if var_73_17 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601016", "story_v_out_910601.awb") ~= 0 then
					local var_73_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601016", "story_v_out_910601.awb") / 1000

					if var_73_18 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_12
					end

					if var_73_14.prefab_name ~= "" and arg_70_1.actors_[var_73_14.prefab_name] ~= nil then
						local var_73_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_14.prefab_name].transform, "story_v_out_910601", "910601016", "story_v_out_910601.awb")

						arg_70_1:RecordAudio("910601016", var_73_19)
						arg_70_1:RecordAudio("910601016", var_73_19)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_910601", "910601016", "story_v_out_910601.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_910601", "910601016", "story_v_out_910601.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_20 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_20 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_20

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_20 and arg_70_1.time_ < var_73_12 + var_73_20 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play910601017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 910601017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play910601018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1028ui_story"]) and arg_74_1.var_.characterEffect1028ui_story == nil then
				arg_74_1.var_.characterEffect1028ui_story = arg_74_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1028ui_story"]) then
				if arg_74_1.var_.characterEffect1028ui_story and not isNil(arg_74_1.actors_["1028ui_story"]) then
					arg_74_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1028ui_story"]) and arg_74_1.var_.characterEffect1028ui_story then
				arg_74_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_77_1 = arg_74_1.actors_["1028ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1028ui_story = var_77_1.localPosition
			end

			local var_77_2 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 then
				var_77_1.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_2)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 then
				var_77_1.localPosition = Vector3.New(0, 100, 0)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			local var_77_3 = 0
			local var_77_4 = 1.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_3 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_5 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(910601017).content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 52 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_5) / 52)

				if (52 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_5) / 52)) > 0 and var_77_4 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_3 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_3
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_4, arg_74_1.talkMaxDuration)

			if var_77_3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_3 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_3) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_3 + var_77_8 and arg_74_1.time_ < var_77_3 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play910601018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 910601018
		arg_78_1.duration_ = 3.4

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play910601019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1028ui_story = arg_78_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1028ui_story"].transform.position).z)
				arg_78_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1028ui_story"].transform.localEulerAngles = arg_78_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, -0.9, -5.9)
				arg_78_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["1028ui_story"].transform.position).z)
				arg_78_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["1028ui_story"].transform.localEulerAngles = arg_78_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["1028ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1028ui_story == nil then
				arg_78_1.var_.characterEffect1028ui_story = var_81_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 and not isNil(var_81_1) then
				if arg_78_1.var_.characterEffect1028ui_story and not isNil(var_81_1) then
					arg_78_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 and not isNil(var_81_1) and arg_78_1.var_.characterEffect1028ui_story then
				arg_78_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_2")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_81_4 = 0
			local var_81_5 = 0.5

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(910601018)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 20 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 20)

				if (20 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 20)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601018", "story_v_out_910601.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601018", "story_v_out_910601.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_910601", "910601018", "story_v_out_910601.awb")

						arg_78_1:RecordAudio("910601018", var_81_11)
						arg_78_1:RecordAudio("910601018", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_910601", "910601018", "story_v_out_910601.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_910601", "910601018", "story_v_out_910601.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play910601019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 910601019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play910601020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1028ui_story"]) and arg_82_1.var_.characterEffect1028ui_story == nil then
				arg_82_1.var_.characterEffect1028ui_story = arg_82_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1028ui_story"]) then
				if arg_82_1.var_.characterEffect1028ui_story and not isNil(arg_82_1.actors_["1028ui_story"]) then
					arg_82_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1028ui_story"]) and arg_82_1.var_.characterEffect1028ui_story then
				arg_82_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 0.075

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(910601019).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 3 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 3)

				if (3 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 3)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_6 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_6

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_6 and arg_82_1.time_ < var_85_1 + var_85_6 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play910601020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 910601020
		arg_86_1.duration_ = 7.9

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play910601021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1059ui_story = arg_86_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1059ui_story"].transform.position).z)
				arg_86_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1059ui_story"].transform.localEulerAngles = arg_86_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_86_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1059ui_story"].transform.position).z)
				arg_86_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1059ui_story"].transform.localEulerAngles = arg_86_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1059ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1059ui_story == nil then
				arg_86_1.var_.characterEffect1059ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect1059ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1059ui_story then
				arg_86_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_89_4 = arg_86_1.actors_["1028ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1028ui_story = var_89_4.localPosition
			end

			local var_89_5 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				var_89_4.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_5)
				var_89_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_4.position).x, (manager.ui.mainCamera.transform.position - var_89_4.position).y, (manager.ui.mainCamera.transform.position - var_89_4.position).z)
				var_89_4.localEulerAngles.z = 0
				var_89_4.localEulerAngles.x = 0
				var_89_4.localEulerAngles = var_89_4.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 then
				var_89_4.localPosition = Vector3.New(0, 100, 0)
				var_89_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_4.position).x, (manager.ui.mainCamera.transform.position - var_89_4.position).y, (manager.ui.mainCamera.transform.position - var_89_4.position).z)
				var_89_4.localEulerAngles.z = 0
				var_89_4.localEulerAngles.x = 0
				var_89_4.localEulerAngles = var_89_4.localEulerAngles
			end

			local var_89_6 = arg_86_1.actors_["1028ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect1028ui_story == nil then
				arg_86_1.var_.characterEffect1028ui_story = var_89_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_7 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 and not isNil(var_89_6) then
				if arg_86_1.var_.characterEffect1028ui_story and not isNil(var_89_6) then
					arg_86_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_7)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect1028ui_story then
				arg_86_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_89_8 = 0
			local var_89_9 = 0.875

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_10 = arg_86_1:GetWordFromCfg(910601020)
				local var_89_11 = arg_86_1:FormatText(var_89_10.content)

				arg_86_1.text_.text = var_89_11

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 35 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 35)

				if (35 <= 0 and var_89_9 or var_89_9 * (utf8.len(var_89_11) / 35)) > 0 and var_89_9 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_11
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601020", "story_v_out_910601.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601020", "story_v_out_910601.awb") / 1000

					if var_89_14 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_8
					end

					if var_89_10.prefab_name ~= "" and arg_86_1.actors_[var_89_10.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_10.prefab_name].transform, "story_v_out_910601", "910601020", "story_v_out_910601.awb")

						arg_86_1:RecordAudio("910601020", var_89_15)
						arg_86_1:RecordAudio("910601020", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_910601", "910601020", "story_v_out_910601.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_910601", "910601020", "story_v_out_910601.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_16 and arg_86_1.time_ < var_89_8 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play910601021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 910601021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play910601022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1059ui_story"]) and arg_90_1.var_.characterEffect1059ui_story == nil then
				arg_90_1.var_.characterEffect1059ui_story = arg_90_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1059ui_story"]) then
				if arg_90_1.var_.characterEffect1059ui_story and not isNil(arg_90_1.actors_["1059ui_story"]) then
					arg_90_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1059ui_story"]) and arg_90_1.var_.characterEffect1059ui_story then
				arg_90_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.675

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(910601021).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 27 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 27)

				if (27 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 27)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play910601022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 910601022
		arg_94_1.duration_ = 2.57

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play910601023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1048ui_story = arg_94_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1048ui_story"].transform.position).z)
				arg_94_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1048ui_story"].transform.localEulerAngles = arg_94_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_94_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1048ui_story"].transform.position).z)
				arg_94_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1048ui_story"].transform.localEulerAngles = arg_94_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_97_1 = arg_94_1.actors_["1048ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1048ui_story == nil then
				arg_94_1.var_.characterEffect1048ui_story = var_97_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 and not isNil(var_97_1) then
				if arg_94_1.var_.characterEffect1048ui_story and not isNil(var_97_1) then
					arg_94_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1048ui_story then
				arg_94_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_97_4 = arg_94_1.actors_["1059ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1059ui_story = var_97_4.localPosition
			end

			local var_97_5 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_5 then
				var_97_4.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_5)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_5 and arg_94_1.time_ < 0 + var_97_5 + arg_97_0 then
				var_97_4.localPosition = Vector3.New(0, 100, 0)
				var_97_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_4.position).x, (manager.ui.mainCamera.transform.position - var_97_4.position).y, (manager.ui.mainCamera.transform.position - var_97_4.position).z)
				var_97_4.localEulerAngles.z = 0
				var_97_4.localEulerAngles.x = 0
				var_97_4.localEulerAngles = var_97_4.localEulerAngles
			end

			local var_97_6 = arg_94_1.actors_["1059ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1059ui_story == nil then
				arg_94_1.var_.characterEffect1059ui_story = var_97_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 and not isNil(var_97_6) then
				if arg_94_1.var_.characterEffect1059ui_story and not isNil(var_97_6) then
					arg_94_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_7)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1059ui_story then
				arg_94_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_97_8 = 0
			local var_97_9 = 0.225

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(910601022)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 9 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 9)

				if (9 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 9)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601022", "story_v_out_910601.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601022", "story_v_out_910601.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_910601", "910601022", "story_v_out_910601.awb")

						arg_94_1:RecordAudio("910601022", var_97_15)
						arg_94_1:RecordAudio("910601022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_910601", "910601022", "story_v_out_910601.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_910601", "910601022", "story_v_out_910601.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play910601023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 910601023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play910601024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1048ui_story"]) and arg_98_1.var_.characterEffect1048ui_story == nil then
				arg_98_1.var_.characterEffect1048ui_story = arg_98_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1048ui_story"]) then
				if arg_98_1.var_.characterEffect1048ui_story and not isNil(arg_98_1.actors_["1048ui_story"]) then
					arg_98_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1048ui_story"]) and arg_98_1.var_.characterEffect1048ui_story then
				arg_98_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.15

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(910601023).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 6 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 6)

				if (6 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 6)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play910601024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 910601024
		arg_102_1.duration_ = 6.3

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play910601025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1059ui_story = arg_102_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1059ui_story"].transform.position).z)
				arg_102_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1059ui_story"].transform.localEulerAngles = arg_102_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_102_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1059ui_story"].transform.position).z)
				arg_102_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1059ui_story"].transform.localEulerAngles = arg_102_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1059ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1059ui_story == nil then
				arg_102_1.var_.characterEffect1059ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1059ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1059ui_story then
				arg_102_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_4 = arg_102_1.actors_["1048ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1048ui_story = var_105_4.localPosition
			end

			local var_105_5 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_5 then
				var_105_4.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_5)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_5 and arg_102_1.time_ < 0 + var_105_5 + arg_105_0 then
				var_105_4.localPosition = Vector3.New(0, 100, 0)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			local var_105_6 = arg_102_1.actors_["1048ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_6) and arg_102_1.var_.characterEffect1048ui_story == nil then
				arg_102_1.var_.characterEffect1048ui_story = var_105_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_7 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 and not isNil(var_105_6) then
				if arg_102_1.var_.characterEffect1048ui_story and not isNil(var_105_6) then
					arg_102_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_7)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 and not isNil(var_105_6) and arg_102_1.var_.characterEffect1048ui_story then
				arg_102_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_105_8 = 0
			local var_105_9 = 0.675

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_10 = arg_102_1:GetWordFromCfg(910601024)
				local var_105_11 = arg_102_1:FormatText(var_105_10.content)

				arg_102_1.text_.text = var_105_11

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 27 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 27)

				if (27 <= 0 and var_105_9 or var_105_9 * (utf8.len(var_105_11) / 27)) > 0 and var_105_9 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_11
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601024", "story_v_out_910601.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601024", "story_v_out_910601.awb") / 1000

					if var_105_14 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_8
					end

					if var_105_10.prefab_name ~= "" and arg_102_1.actors_[var_105_10.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_10.prefab_name].transform, "story_v_out_910601", "910601024", "story_v_out_910601.awb")

						arg_102_1:RecordAudio("910601024", var_105_15)
						arg_102_1:RecordAudio("910601024", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_910601", "910601024", "story_v_out_910601.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_910601", "910601024", "story_v_out_910601.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_16 and arg_102_1.time_ < var_105_8 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play910601025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 910601025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play910601026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1059ui_story"]) and arg_106_1.var_.characterEffect1059ui_story == nil then
				arg_106_1.var_.characterEffect1059ui_story = arg_106_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1059ui_story"]) then
				if arg_106_1.var_.characterEffect1059ui_story and not isNil(arg_106_1.actors_["1059ui_story"]) then
					arg_106_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1059ui_story"]) and arg_106_1.var_.characterEffect1059ui_story then
				arg_106_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 0.05

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(910601025).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 2 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 2)

				if (2 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 2)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play910601026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 910601026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play910601027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.7

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(910601026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 28 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 28)

				if (28 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 28)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play910601027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 910601027
		arg_114_1.duration_ = 2.57

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play910601028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1028ui_story = arg_114_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1028ui_story"].transform.position).z)
				arg_114_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1028ui_story"].transform.localEulerAngles = arg_114_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, -0.9, -5.9)
				arg_114_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1028ui_story"].transform.position).z)
				arg_114_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1028ui_story"].transform.localEulerAngles = arg_114_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["1028ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1028ui_story == nil then
				arg_114_1.var_.characterEffect1028ui_story = var_117_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 and not isNil(var_117_1) then
				if arg_114_1.var_.characterEffect1028ui_story and not isNil(var_117_1) then
					arg_114_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1028ui_story then
				arg_114_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action7_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_117_4 = arg_114_1.actors_["1059ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1059ui_story = var_117_4.localPosition
			end

			local var_117_5 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_5 then
				var_117_4.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_5)
				var_117_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_4.position).x, (manager.ui.mainCamera.transform.position - var_117_4.position).y, (manager.ui.mainCamera.transform.position - var_117_4.position).z)
				var_117_4.localEulerAngles.z = 0
				var_117_4.localEulerAngles.x = 0
				var_117_4.localEulerAngles = var_117_4.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_5 and arg_114_1.time_ < 0 + var_117_5 + arg_117_0 then
				var_117_4.localPosition = Vector3.New(0, 100, 0)
				var_117_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_4.position).x, (manager.ui.mainCamera.transform.position - var_117_4.position).y, (manager.ui.mainCamera.transform.position - var_117_4.position).z)
				var_117_4.localEulerAngles.z = 0
				var_117_4.localEulerAngles.x = 0
				var_117_4.localEulerAngles = var_117_4.localEulerAngles
			end

			local var_117_6 = arg_114_1.actors_["1059ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_6) and arg_114_1.var_.characterEffect1059ui_story == nil then
				arg_114_1.var_.characterEffect1059ui_story = var_117_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_7 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 and not isNil(var_117_6) then
				if arg_114_1.var_.characterEffect1059ui_story and not isNil(var_117_6) then
					arg_114_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_7)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 and not isNil(var_117_6) and arg_114_1.var_.characterEffect1059ui_story then
				arg_114_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_117_8 = 0
			local var_117_9 = 0.2

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_10 = arg_114_1:GetWordFromCfg(910601027)
				local var_117_11 = arg_114_1:FormatText(var_117_10.content)

				arg_114_1.text_.text = var_117_11

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_13 = 8 <= 0 and var_117_9 or var_117_9 * (utf8.len(var_117_11) / 8)

				if (8 <= 0 and var_117_9 or var_117_9 * (utf8.len(var_117_11) / 8)) > 0 and var_117_9 < var_117_13 then
					arg_114_1.talkMaxDuration = var_117_13

					if var_117_13 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_8
					end
				end

				arg_114_1.text_.text = var_117_11
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601027", "story_v_out_910601.awb") ~= 0 then
					local var_117_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601027", "story_v_out_910601.awb") / 1000

					if var_117_14 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_14 + var_117_8
					end

					if var_117_10.prefab_name ~= "" and arg_114_1.actors_[var_117_10.prefab_name] ~= nil then
						local var_117_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_10.prefab_name].transform, "story_v_out_910601", "910601027", "story_v_out_910601.awb")

						arg_114_1:RecordAudio("910601027", var_117_15)
						arg_114_1:RecordAudio("910601027", var_117_15)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_910601", "910601027", "story_v_out_910601.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_910601", "910601027", "story_v_out_910601.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_16 = math.max(var_117_9, arg_114_1.talkMaxDuration)

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_16 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_8) / var_117_16

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_8 + var_117_16 and arg_114_1.time_ < var_117_8 + var_117_16 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play910601028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 910601028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play910601029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1028ui_story"]) and arg_118_1.var_.characterEffect1028ui_story == nil then
				arg_118_1.var_.characterEffect1028ui_story = arg_118_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1028ui_story"]) then
				if arg_118_1.var_.characterEffect1028ui_story and not isNil(arg_118_1.actors_["1028ui_story"]) then
					arg_118_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1028ui_story"]) and arg_118_1.var_.characterEffect1028ui_story then
				arg_118_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_121_1 = arg_118_1.actors_["1028ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1028ui_story = var_121_1.localPosition
			end

			local var_121_2 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 then
				var_121_1.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_2)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 then
				var_121_1.localPosition = Vector3.New(0, 100, 0)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			local var_121_3 = 0
			local var_121_4 = 0.75

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_3 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_5 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(910601028).content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 30 <= 0 and var_121_4 or var_121_4 * (utf8.len(var_121_5) / 30)

				if (30 <= 0 and var_121_4 or var_121_4 * (utf8.len(var_121_5) / 30)) > 0 and var_121_4 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_3 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_3
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_8 = math.max(var_121_4, arg_118_1.talkMaxDuration)

			if var_121_3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_3 + var_121_8 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_3) / var_121_8

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_3 + var_121_8 and arg_118_1.time_ < var_121_3 + var_121_8 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play910601029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 910601029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play910601030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 1.125

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(910601029).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 45 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 45)

				if (45 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 45)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play910601030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 910601030
		arg_126_1.duration_ = 3.73

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play910601031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1028ui_story = arg_126_1.actors_["1028ui_story"].transform.localPosition

				arg_126_1:ShowWeapon(arg_126_1.var_["1028ui_story" .. "Animator"].transform, false)
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1028ui_story"].transform.position).z)
				arg_126_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1028ui_story"].transform.localEulerAngles = arg_126_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, -0.9, -5.9)
				arg_126_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1028ui_story"].transform.position).z)
				arg_126_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1028ui_story"].transform.localEulerAngles = arg_126_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["1028ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1028ui_story == nil then
				arg_126_1.var_.characterEffect1028ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect1028ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1028ui_story then
				arg_126_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action4_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_129_4 = arg_126_1.actors_["1059ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1059ui_story = var_129_4.localPosition
			end

			local var_129_5 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_5 then
				var_129_4.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_5)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_5 and arg_126_1.time_ < 0 + var_129_5 + arg_129_0 then
				var_129_4.localPosition = Vector3.New(0, 100, 0)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles
			end

			local var_129_6 = arg_126_1.actors_["1059ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_6) and arg_126_1.var_.characterEffect1059ui_story == nil then
				arg_126_1.var_.characterEffect1059ui_story = var_129_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_7 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 and not isNil(var_129_6) then
				if arg_126_1.var_.characterEffect1059ui_story and not isNil(var_129_6) then
					arg_126_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_7)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 and not isNil(var_129_6) and arg_126_1.var_.characterEffect1059ui_story then
				arg_126_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_129_8 = arg_126_1.actors_["1048ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1048ui_story = var_129_8.localPosition
			end

			local var_129_9 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_9 then
				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_9)
				var_129_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_8.position).x, (manager.ui.mainCamera.transform.position - var_129_8.position).y, (manager.ui.mainCamera.transform.position - var_129_8.position).z)
				var_129_8.localEulerAngles.z = 0
				var_129_8.localEulerAngles.x = 0
				var_129_8.localEulerAngles = var_129_8.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_9 and arg_126_1.time_ < 0 + var_129_9 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(0, 100, 0)
				var_129_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_8.position).x, (manager.ui.mainCamera.transform.position - var_129_8.position).y, (manager.ui.mainCamera.transform.position - var_129_8.position).z)
				var_129_8.localEulerAngles.z = 0
				var_129_8.localEulerAngles.x = 0
				var_129_8.localEulerAngles = var_129_8.localEulerAngles
			end

			local var_129_10 = arg_126_1.actors_["1048ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_10) and arg_126_1.var_.characterEffect1048ui_story == nil then
				arg_126_1.var_.characterEffect1048ui_story = var_129_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_11 and not isNil(var_129_10) then
				if arg_126_1.var_.characterEffect1048ui_story and not isNil(var_129_10) then
					arg_126_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_11)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_11 and arg_126_1.time_ < 0 + var_129_11 + arg_129_0 and not isNil(var_129_10) and arg_126_1.var_.characterEffect1048ui_story then
				arg_126_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_129_12 = 0
			local var_129_13 = 0.25

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_12 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_14 = arg_126_1:GetWordFromCfg(910601030)
				local var_129_15 = arg_126_1:FormatText(var_129_14.content)

				arg_126_1.text_.text = var_129_15

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 10 <= 0 and var_129_13 or var_129_13 * (utf8.len(var_129_15) / 10)

				if (10 <= 0 and var_129_13 or var_129_13 * (utf8.len(var_129_15) / 10)) > 0 and var_129_13 < var_129_17 then
					arg_126_1.talkMaxDuration = var_129_17

					if var_129_17 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_17 + var_129_12
					end
				end

				arg_126_1.text_.text = var_129_15
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601030", "story_v_out_910601.awb") ~= 0 then
					local var_129_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601030", "story_v_out_910601.awb") / 1000

					if var_129_18 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_18 + var_129_12
					end

					if var_129_14.prefab_name ~= "" and arg_126_1.actors_[var_129_14.prefab_name] ~= nil then
						local var_129_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_14.prefab_name].transform, "story_v_out_910601", "910601030", "story_v_out_910601.awb")

						arg_126_1:RecordAudio("910601030", var_129_19)
						arg_126_1:RecordAudio("910601030", var_129_19)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_910601", "910601030", "story_v_out_910601.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_910601", "910601030", "story_v_out_910601.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_20 = math.max(var_129_13, arg_126_1.talkMaxDuration)

			if var_129_12 <= arg_126_1.time_ and arg_126_1.time_ < var_129_12 + var_129_20 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_12) / var_129_20

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_12 + var_129_20 and arg_126_1.time_ < var_129_12 + var_129_20 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play910601031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 910601031
		arg_130_1.duration_ = 3.57

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play910601032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1028ui_story"]) and arg_130_1.var_.characterEffect1028ui_story == nil then
				arg_130_1.var_.characterEffect1028ui_story = arg_130_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1028ui_story"]) then
				if arg_130_1.var_.characterEffect1028ui_story and not isNil(arg_130_1.actors_["1028ui_story"]) then
					arg_130_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1028ui_story"]) and arg_130_1.var_.characterEffect1028ui_story then
				arg_130_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_133_1 = arg_130_1.actors_["1059ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1059ui_story = var_133_1.localPosition
			end

			local var_133_2 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 then
				var_133_1.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_130_1.time_ - 0) / var_133_2)
				var_133_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_1.position).x, (manager.ui.mainCamera.transform.position - var_133_1.position).y, (manager.ui.mainCamera.transform.position - var_133_1.position).z)
				var_133_1.localEulerAngles.z = 0
				var_133_1.localEulerAngles.x = 0
				var_133_1.localEulerAngles = var_133_1.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 then
				var_133_1.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_133_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_1.position).x, (manager.ui.mainCamera.transform.position - var_133_1.position).y, (manager.ui.mainCamera.transform.position - var_133_1.position).z)
				var_133_1.localEulerAngles.z = 0
				var_133_1.localEulerAngles.x = 0
				var_133_1.localEulerAngles = var_133_1.localEulerAngles
			end

			local var_133_3 = arg_130_1.actors_["1059ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1059ui_story == nil then
				arg_130_1.var_.characterEffect1059ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect1059ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1059ui_story then
				arg_130_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			local var_133_6 = arg_130_1.actors_["1048ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1048ui_story = var_133_6.localPosition

				arg_130_1:ShowWeapon(arg_130_1.var_["1048ui_story" .. "Animator"].transform, false)
			end

			local var_133_7 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				var_133_6.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_130_1.time_ - 0) / var_133_7)
				var_133_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_6.position).x, (manager.ui.mainCamera.transform.position - var_133_6.position).y, (manager.ui.mainCamera.transform.position - var_133_6.position).z)
				var_133_6.localEulerAngles.z = 0
				var_133_6.localEulerAngles.x = 0
				var_133_6.localEulerAngles = var_133_6.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				var_133_6.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_133_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_6.position).x, (manager.ui.mainCamera.transform.position - var_133_6.position).y, (manager.ui.mainCamera.transform.position - var_133_6.position).z)
				var_133_6.localEulerAngles.z = 0
				var_133_6.localEulerAngles.x = 0
				var_133_6.localEulerAngles = var_133_6.localEulerAngles
			end

			local var_133_8 = arg_130_1.actors_["1048ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_8) and arg_130_1.var_.characterEffect1048ui_story == nil then
				arg_130_1.var_.characterEffect1048ui_story = var_133_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_9 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_9 and not isNil(var_133_8) then
				if arg_130_1.var_.characterEffect1048ui_story and not isNil(var_133_8) then
					arg_130_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_9 and arg_130_1.time_ < 0 + var_133_9 + arg_133_0 and not isNil(var_133_8) and arg_130_1.var_.characterEffect1048ui_story then
				arg_130_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_133_11 = arg_130_1.actors_["1028ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1028ui_story = var_133_11.localPosition

				arg_130_1:ShowWeapon(arg_130_1.var_["1028ui_story" .. "Animator"].transform, false)
			end

			local var_133_12 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_12 then
				var_133_11.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_12)
				var_133_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_11.position).x, (manager.ui.mainCamera.transform.position - var_133_11.position).y, (manager.ui.mainCamera.transform.position - var_133_11.position).z)
				var_133_11.localEulerAngles.z = 0
				var_133_11.localEulerAngles.x = 0
				var_133_11.localEulerAngles = var_133_11.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_12 and arg_130_1.time_ < 0 + var_133_12 + arg_133_0 then
				var_133_11.localPosition = Vector3.New(0, 100, 0)
				var_133_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_11.position).x, (manager.ui.mainCamera.transform.position - var_133_11.position).y, (manager.ui.mainCamera.transform.position - var_133_11.position).z)
				var_133_11.localEulerAngles.z = 0
				var_133_11.localEulerAngles.x = 0
				var_133_11.localEulerAngles = var_133_11.localEulerAngles
			end

			local var_133_13 = 0
			local var_133_14 = 0.225

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_13 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(910601031)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_18 = 9 <= 0 and var_133_14 or var_133_14 * (utf8.len(var_133_16) / 9)

				if (9 <= 0 and var_133_14 or var_133_14 * (utf8.len(var_133_16) / 9)) > 0 and var_133_14 < var_133_18 then
					arg_130_1.talkMaxDuration = var_133_18

					if var_133_18 + var_133_13 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_18 + var_133_13
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601031", "story_v_out_910601.awb") ~= 0 then
					local var_133_19 = manager.audio:GetVoiceLength("story_v_out_910601", "910601031", "story_v_out_910601.awb") / 1000

					if var_133_19 + var_133_13 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_13
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_910601", "910601031", "story_v_out_910601.awb")

						arg_130_1:RecordAudio("910601031", var_133_20)
						arg_130_1:RecordAudio("910601031", var_133_20)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_910601", "910601031", "story_v_out_910601.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_910601", "910601031", "story_v_out_910601.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_21 = math.max(var_133_14, arg_130_1.talkMaxDuration)

			if var_133_13 <= arg_130_1.time_ and arg_130_1.time_ < var_133_13 + var_133_21 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_13) / var_133_21

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_13 + var_133_21 and arg_130_1.time_ < var_133_13 + var_133_21 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play910601032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 910601032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play910601033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1048ui_story"]) and arg_134_1.var_.characterEffect1048ui_story == nil then
				arg_134_1.var_.characterEffect1048ui_story = arg_134_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1048ui_story"]) then
				if arg_134_1.var_.characterEffect1048ui_story and not isNil(arg_134_1.actors_["1048ui_story"]) then
					arg_134_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1048ui_story"]) and arg_134_1.var_.characterEffect1048ui_story then
				arg_134_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_137_1 = arg_134_1.actors_["1059ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1059ui_story == nil then
				arg_134_1.var_.characterEffect1059ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect1059ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_2)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1059ui_story then
				arg_134_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_137_3 = 0
			local var_137_4 = 0.35

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_5 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(910601032).content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 14 <= 0 and var_137_4 or var_137_4 * (utf8.len(var_137_5) / 14)

				if (14 <= 0 and var_137_4 or var_137_4 * (utf8.len(var_137_5) / 14)) > 0 and var_137_4 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_3 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_3
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_4, arg_134_1.talkMaxDuration)

			if var_137_3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_3 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_3) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_3 + var_137_8 and arg_134_1.time_ < var_137_3 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play910601033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 910601033
		arg_138_1.duration_ = 4.23

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play910601034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1084ui_story = arg_138_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).z)
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles = arg_138_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_138_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1084ui_story"].transform.position).z)
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1084ui_story"].transform.localEulerAngles = arg_138_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1084ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1084ui_story then
				arg_138_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_141_4 = arg_138_1.actors_["1028ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1028ui_story = var_141_4.localPosition
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_4.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_5)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_4.localPosition = Vector3.New(0, 100, 0)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			local var_141_6 = arg_138_1.actors_["1028ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1028ui_story == nil then
				arg_138_1.var_.characterEffect1028ui_story = var_141_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_7 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 and not isNil(var_141_6) then
				if arg_138_1.var_.characterEffect1028ui_story and not isNil(var_141_6) then
					arg_138_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_7)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 and not isNil(var_141_6) and arg_138_1.var_.characterEffect1028ui_story then
				arg_138_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_141_8 = arg_138_1.actors_["1059ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1059ui_story = var_141_8.localPosition
			end

			local var_141_9 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_9 then
				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_9)
				var_141_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_8.position).x, (manager.ui.mainCamera.transform.position - var_141_8.position).y, (manager.ui.mainCamera.transform.position - var_141_8.position).z)
				var_141_8.localEulerAngles.z = 0
				var_141_8.localEulerAngles.x = 0
				var_141_8.localEulerAngles = var_141_8.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_9 and arg_138_1.time_ < 0 + var_141_9 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(0, 100, 0)
				var_141_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_8.position).x, (manager.ui.mainCamera.transform.position - var_141_8.position).y, (manager.ui.mainCamera.transform.position - var_141_8.position).z)
				var_141_8.localEulerAngles.z = 0
				var_141_8.localEulerAngles.x = 0
				var_141_8.localEulerAngles = var_141_8.localEulerAngles
			end

			local var_141_10 = arg_138_1.actors_["1048ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1048ui_story = var_141_10.localPosition
			end

			local var_141_11 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_11 then
				var_141_10.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_11)
				var_141_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_10.position).x, (manager.ui.mainCamera.transform.position - var_141_10.position).y, (manager.ui.mainCamera.transform.position - var_141_10.position).z)
				var_141_10.localEulerAngles.z = 0
				var_141_10.localEulerAngles.x = 0
				var_141_10.localEulerAngles = var_141_10.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_11 and arg_138_1.time_ < 0 + var_141_11 + arg_141_0 then
				var_141_10.localPosition = Vector3.New(0, 100, 0)
				var_141_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_10.position).x, (manager.ui.mainCamera.transform.position - var_141_10.position).y, (manager.ui.mainCamera.transform.position - var_141_10.position).z)
				var_141_10.localEulerAngles.z = 0
				var_141_10.localEulerAngles.x = 0
				var_141_10.localEulerAngles = var_141_10.localEulerAngles
			end

			local var_141_12 = 0
			local var_141_13 = 0.5

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_12 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_14 = arg_138_1:GetWordFromCfg(910601033)
				local var_141_15 = arg_138_1:FormatText(var_141_14.content)

				arg_138_1.text_.text = var_141_15

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_17 = 20 <= 0 and var_141_13 or var_141_13 * (utf8.len(var_141_15) / 20)

				if (20 <= 0 and var_141_13 or var_141_13 * (utf8.len(var_141_15) / 20)) > 0 and var_141_13 < var_141_17 then
					arg_138_1.talkMaxDuration = var_141_17

					if var_141_17 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_12
					end
				end

				arg_138_1.text_.text = var_141_15
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601033", "story_v_out_910601.awb") ~= 0 then
					local var_141_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601033", "story_v_out_910601.awb") / 1000

					if var_141_18 + var_141_12 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_18 + var_141_12
					end

					if var_141_14.prefab_name ~= "" and arg_138_1.actors_[var_141_14.prefab_name] ~= nil then
						local var_141_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_14.prefab_name].transform, "story_v_out_910601", "910601033", "story_v_out_910601.awb")

						arg_138_1:RecordAudio("910601033", var_141_19)
						arg_138_1:RecordAudio("910601033", var_141_19)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_910601", "910601033", "story_v_out_910601.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_910601", "910601033", "story_v_out_910601.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_20 = math.max(var_141_13, arg_138_1.talkMaxDuration)

			if var_141_12 <= arg_138_1.time_ and arg_138_1.time_ < var_141_12 + var_141_20 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_12) / var_141_20

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_12 + var_141_20 and arg_138_1.time_ < var_141_12 + var_141_20 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play910601034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 910601034
		arg_142_1.duration_ = 7.03

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play910601035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_145_0 = 0
			local var_145_1 = 0.925

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(910601034)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 37 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 37)

				if (37 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 37)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601034", "story_v_out_910601.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_910601", "910601034", "story_v_out_910601.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_910601", "910601034", "story_v_out_910601.awb")

						arg_142_1:RecordAudio("910601034", var_145_7)
						arg_142_1:RecordAudio("910601034", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_910601", "910601034", "story_v_out_910601.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_910601", "910601034", "story_v_out_910601.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play910601035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 910601035
		arg_146_1.duration_ = 7.37

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play910601036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_149_0 = 0
			local var_149_1 = 1.025

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_2 = arg_146_1:GetWordFromCfg(910601035)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 41 <= 0 and var_149_1 or var_149_1 * (utf8.len(var_149_3) / 41)

				if (41 <= 0 and var_149_1 or var_149_1 * (utf8.len(var_149_3) / 41)) > 0 and var_149_1 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601035", "story_v_out_910601.awb") ~= 0 then
					local var_149_6 = manager.audio:GetVoiceLength("story_v_out_910601", "910601035", "story_v_out_910601.awb") / 1000

					if var_149_6 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_0
					end

					if var_149_2.prefab_name ~= "" and arg_146_1.actors_[var_149_2.prefab_name] ~= nil then
						local var_149_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_2.prefab_name].transform, "story_v_out_910601", "910601035", "story_v_out_910601.awb")

						arg_146_1:RecordAudio("910601035", var_149_7)
						arg_146_1:RecordAudio("910601035", var_149_7)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_910601", "910601035", "story_v_out_910601.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_910601", "910601035", "story_v_out_910601.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_8 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_8 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_8

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_8 and arg_146_1.time_ < var_149_0 + var_149_8 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play910601036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 910601036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play910601037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = arg_150_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1084ui_story"].transform.position).z)
				arg_150_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1084ui_story"].transform.localEulerAngles = arg_150_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1084ui_story"].transform.position).z)
				arg_150_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1084ui_story"].transform.localEulerAngles = arg_150_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_153_1 = 0
			local var_153_2 = 0.5

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(910601036).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 20 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 20)

				if (20 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 20)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play910601037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 910601037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play910601038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_157_0 = 0.6

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				local var_157_1, var_157_2 = math.modf((arg_154_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_157_2 * 0.13, var_157_2 * 0.13, var_157_2 * 0.13) + arg_154_1.var_.shakeOldPos
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				manager.ui.mainCamera.transform.localPosition = arg_154_1.var_.shakeOldPos
			end

			local var_157_3 = 0

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_3 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			if arg_154_1.time_ >= var_157_3 + 0.6 and arg_154_1.time_ < var_157_3 + 0.6 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_4 = 0
			local var_157_5 = 0.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_6 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(910601037).content)

				arg_154_1.text_.text = var_157_6

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_8 = 9 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_6) / 9)

				if (9 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_6) / 9)) > 0 and var_157_5 < var_157_8 then
					arg_154_1.talkMaxDuration = var_157_8

					if var_157_8 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_8 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_6
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_9 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_9 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_9

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_9 and arg_154_1.time_ < var_157_4 + var_157_9 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play910601038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 910601038
		arg_158_1.duration_ = 4.83

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play910601039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1011ui_story = arg_158_1.actors_["1011ui_story"].transform.localPosition

				arg_158_1:ShowWeapon(arg_158_1.var_["1011ui_story" .. "Animator"].transform, false)
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).z)
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles = arg_158_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_158_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).z)
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles = arg_158_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1011ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1011ui_story == nil then
				arg_158_1.var_.characterEffect1011ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1011ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1011ui_story then
				arg_158_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_161_4 = 0
			local var_161_5 = 0.6

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(910601038)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 24 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 24)

				if (24 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 24)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601038", "story_v_out_910601.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601038", "story_v_out_910601.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_910601", "910601038", "story_v_out_910601.awb")

						arg_158_1:RecordAudio("910601038", var_161_11)
						arg_158_1:RecordAudio("910601038", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_910601", "910601038", "story_v_out_910601.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_910601", "910601038", "story_v_out_910601.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play910601039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 910601039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play910601040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1011ui_story"]) and arg_162_1.var_.characterEffect1011ui_story == nil then
				arg_162_1.var_.characterEffect1011ui_story = arg_162_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1011ui_story"]) then
				if arg_162_1.var_.characterEffect1011ui_story and not isNil(arg_162_1.actors_["1011ui_story"]) then
					arg_162_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1011ui_story"]) and arg_162_1.var_.characterEffect1011ui_story then
				arg_162_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.4

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(910601039).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 16 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 16)

				if (16 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 16)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play910601040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 910601040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play910601041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.675

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(910601040).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 27 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 27)

				if (27 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 27)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play910601041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 910601041
		arg_170_1.duration_ = 2

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play910601042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1011ui_story = arg_170_1.actors_["1011ui_story"].transform.localPosition

				arg_170_1:ShowWeapon(arg_170_1.var_["1011ui_story" .. "Animator"].transform, false)
			end

			local var_173_0 = 0.1

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).z)
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles = arg_170_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_170_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).z)
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles = arg_170_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_173_1 = arg_170_1.actors_["1084ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1084ui_story = var_173_1.localPosition
			end

			local var_173_2 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 then
				var_173_1.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_170_1.time_ - 0) / var_173_2)
				var_173_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_1.position).x, (manager.ui.mainCamera.transform.position - var_173_1.position).y, (manager.ui.mainCamera.transform.position - var_173_1.position).z)
				var_173_1.localEulerAngles.z = 0
				var_173_1.localEulerAngles.x = 0
				var_173_1.localEulerAngles = var_173_1.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 then
				var_173_1.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_173_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_1.position).x, (manager.ui.mainCamera.transform.position - var_173_1.position).y, (manager.ui.mainCamera.transform.position - var_173_1.position).z)
				var_173_1.localEulerAngles.z = 0
				var_173_1.localEulerAngles.x = 0
				var_173_1.localEulerAngles = var_173_1.localEulerAngles
			end

			local var_173_3 = arg_170_1.actors_["1084ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_3) and arg_170_1.var_.characterEffect1084ui_story == nil then
				arg_170_1.var_.characterEffect1084ui_story = var_173_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_4 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 and not isNil(var_173_3) then
				if arg_170_1.var_.characterEffect1084ui_story and not isNil(var_173_3) then
					arg_170_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_4)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 and not isNil(var_173_3) and arg_170_1.var_.characterEffect1084ui_story then
				arg_170_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action446")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_173_5 = 0
			local var_173_6 = 0.05

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[661].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_7 = arg_170_1:GetWordFromCfg(910601041)
				local var_173_8 = arg_170_1:FormatText(var_173_7.content)

				arg_170_1.text_.text = var_173_8

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_10 = 2 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 2)

				if (2 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 2)) > 0 and var_173_6 < var_173_10 then
					arg_170_1.talkMaxDuration = var_173_10

					if var_173_10 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_8
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601041", "story_v_out_910601.awb") ~= 0 then
					local var_173_11 = manager.audio:GetVoiceLength("story_v_out_910601", "910601041", "story_v_out_910601.awb") / 1000

					if var_173_11 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_5
					end

					if var_173_7.prefab_name ~= "" and arg_170_1.actors_[var_173_7.prefab_name] ~= nil then
						local var_173_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_7.prefab_name].transform, "story_v_out_910601", "910601041", "story_v_out_910601.awb")

						arg_170_1:RecordAudio("910601041", var_173_12)
						arg_170_1:RecordAudio("910601041", var_173_12)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_910601", "910601041", "story_v_out_910601.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_910601", "910601041", "story_v_out_910601.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_13 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_13 and arg_170_1.time_ < var_173_5 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play910601042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 910601042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play910601043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.45

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(910601042).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 18 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 18)

				if (18 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 18)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play910601043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 910601043
		arg_178_1.duration_ = 5.47

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play910601044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1084ui_story = arg_178_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).z)
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles = arg_178_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_178_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1084ui_story"].transform.position).z)
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1084ui_story"].transform.localEulerAngles = arg_178_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1084ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1084ui_story == nil then
				arg_178_1.var_.characterEffect1084ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1084ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1084ui_story then
				arg_178_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action474")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_181_4 = 0
			local var_181_5 = 0.55

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(910601043)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 22 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 22)

				if (22 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 22)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601043", "story_v_out_910601.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601043", "story_v_out_910601.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_910601", "910601043", "story_v_out_910601.awb")

						arg_178_1:RecordAudio("910601043", var_181_11)
						arg_178_1:RecordAudio("910601043", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_910601", "910601043", "story_v_out_910601.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_910601", "910601043", "story_v_out_910601.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play910601044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 910601044
		arg_182_1.duration_ = 2.6

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play910601045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1011ui_story = arg_182_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).z)
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles = arg_182_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_182_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).z)
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles = arg_182_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1011ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1011ui_story == nil then
				arg_182_1.var_.characterEffect1011ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1011ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1011ui_story then
				arg_182_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_185_4 = arg_182_1.actors_["1084ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect1084ui_story == nil then
				arg_182_1.var_.characterEffect1084ui_story = var_185_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_5 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_5 and not isNil(var_185_4) then
				if arg_182_1.var_.characterEffect1084ui_story and not isNil(var_185_4) then
					arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_5)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_5 and arg_182_1.time_ < 0 + var_185_5 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.characterEffect1084ui_story then
				arg_182_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_185_6 = 0
			local var_185_7 = 0.325

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_8 = arg_182_1:GetWordFromCfg(910601044)
				local var_185_9 = arg_182_1:FormatText(var_185_8.content)

				arg_182_1.text_.text = var_185_9

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 13 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_9) / 13)

				if (13 <= 0 and var_185_7 or var_185_7 * (utf8.len(var_185_9) / 13)) > 0 and var_185_7 < var_185_11 then
					arg_182_1.talkMaxDuration = var_185_11

					if var_185_11 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_9
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601044", "story_v_out_910601.awb") ~= 0 then
					local var_185_12 = manager.audio:GetVoiceLength("story_v_out_910601", "910601044", "story_v_out_910601.awb") / 1000

					if var_185_12 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_12 + var_185_6
					end

					if var_185_8.prefab_name ~= "" and arg_182_1.actors_[var_185_8.prefab_name] ~= nil then
						local var_185_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_8.prefab_name].transform, "story_v_out_910601", "910601044", "story_v_out_910601.awb")

						arg_182_1:RecordAudio("910601044", var_185_13)
						arg_182_1:RecordAudio("910601044", var_185_13)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_910601", "910601044", "story_v_out_910601.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_910601", "910601044", "story_v_out_910601.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_14 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_14 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_14

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_14 and arg_182_1.time_ < var_185_6 + var_185_14 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play910601045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 910601045
		arg_186_1.duration_ = 4.1

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play910601046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1084ui_story = arg_186_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).z)
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles = arg_186_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_186_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).z)
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles = arg_186_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1084ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1084ui_story == nil then
				arg_186_1.var_.characterEffect1084ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect1084ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1084ui_story then
				arg_186_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action447")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_189_4 = arg_186_1.actors_["1011ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect1011ui_story == nil then
				arg_186_1.var_.characterEffect1011ui_story = var_189_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_5 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_5 and not isNil(var_189_4) then
				if arg_186_1.var_.characterEffect1011ui_story and not isNil(var_189_4) then
					arg_186_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_5)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_5 and arg_186_1.time_ < 0 + var_189_5 + arg_189_0 and not isNil(var_189_4) and arg_186_1.var_.characterEffect1011ui_story then
				arg_186_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_189_6 = 0
			local var_189_7 = 0.525

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_8 = arg_186_1:GetWordFromCfg(910601045)
				local var_189_9 = arg_186_1:FormatText(var_189_8.content)

				arg_186_1.text_.text = var_189_9

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 21 <= 0 and var_189_7 or var_189_7 * (utf8.len(var_189_9) / 21)

				if (21 <= 0 and var_189_7 or var_189_7 * (utf8.len(var_189_9) / 21)) > 0 and var_189_7 < var_189_11 then
					arg_186_1.talkMaxDuration = var_189_11

					if var_189_11 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_9
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601045", "story_v_out_910601.awb") ~= 0 then
					local var_189_12 = manager.audio:GetVoiceLength("story_v_out_910601", "910601045", "story_v_out_910601.awb") / 1000

					if var_189_12 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_6
					end

					if var_189_8.prefab_name ~= "" and arg_186_1.actors_[var_189_8.prefab_name] ~= nil then
						local var_189_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_8.prefab_name].transform, "story_v_out_910601", "910601045", "story_v_out_910601.awb")

						arg_186_1:RecordAudio("910601045", var_189_13)
						arg_186_1:RecordAudio("910601045", var_189_13)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_910601", "910601045", "story_v_out_910601.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_910601", "910601045", "story_v_out_910601.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_14 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_14 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_14

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_14 and arg_186_1.time_ < var_189_6 + var_189_14 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play910601046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 910601046
		arg_190_1.duration_ = 5.3

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play910601047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1084ui_story = arg_190_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).z)
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles = arg_190_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_190_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1084ui_story"].transform.position).z)
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1084ui_story"].transform.localEulerAngles = arg_190_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1084ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1084ui_story == nil then
				arg_190_1.var_.characterEffect1084ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1084ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1084ui_story then
				arg_190_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_193_4 = 0
			local var_193_5 = 0.725

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(910601046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 29 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 29)

				if (29 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 29)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601046", "story_v_out_910601.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601046", "story_v_out_910601.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_910601", "910601046", "story_v_out_910601.awb")

						arg_190_1:RecordAudio("910601046", var_193_11)
						arg_190_1:RecordAudio("910601046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_910601", "910601046", "story_v_out_910601.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_910601", "910601046", "story_v_out_910601.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play910601047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 910601047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play910601048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story == nil then
				arg_194_1.var_.characterEffect1084ui_story = arg_194_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) then
				if arg_194_1.var_.characterEffect1084ui_story and not isNil(arg_194_1.actors_["1084ui_story"]) then
					arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1084ui_story"]) and arg_194_1.var_.characterEffect1084ui_story then
				arg_194_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_197_1 = 0
			local var_197_2 = 0.125

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(910601047).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 5 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 5)

				if (5 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 5)) > 0 and var_197_2 < var_197_5 then
					arg_194_1.talkMaxDuration = var_197_5

					if var_197_5 + var_197_1 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + var_197_1
					end
				end

				arg_194_1.text_.text = var_197_3
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_6 = math.max(var_197_2, arg_194_1.talkMaxDuration)

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_6 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_1) / var_197_6

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_1 + var_197_6 and arg_194_1.time_ < var_197_1 + var_197_6 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play910601048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 910601048
		arg_198_1.duration_ = 5.27

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play910601049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1084ui_story"]) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = arg_198_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1084ui_story"]) then
				if arg_198_1.var_.characterEffect1084ui_story and not isNil(arg_198_1.actors_["1084ui_story"]) then
					arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1084ui_story"]) and arg_198_1.var_.characterEffect1084ui_story then
				arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_201_2 = 0
			local var_201_3 = 0.65

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:GetWordFromCfg(910601048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 26 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 26)

				if (26 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 26)) > 0 and var_201_3 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601048", "story_v_out_910601.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601048", "story_v_out_910601.awb") / 1000

					if var_201_8 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_2
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_910601", "910601048", "story_v_out_910601.awb")

						arg_198_1:RecordAudio("910601048", var_201_9)
						arg_198_1:RecordAudio("910601048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_910601", "910601048", "story_v_out_910601.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_910601", "910601048", "story_v_out_910601.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_10 and arg_198_1.time_ < var_201_2 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play910601049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 910601049
		arg_202_1.duration_ = 4.23

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play910601050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_205_0 = arg_202_1.actors_["1011ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1011ui_story == nil then
				arg_202_1.var_.characterEffect1011ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_1 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 and not isNil(var_205_0) then
				if arg_202_1.var_.characterEffect1011ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1011ui_story then
				arg_202_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_205_3 = arg_202_1.actors_["1084ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_4 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 and not isNil(var_205_3) then
				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_3) then
					arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_4)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect1084ui_story then
				arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_205_5 = 0
			local var_205_6 = 0.475

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_7 = arg_202_1:GetWordFromCfg(910601049)
				local var_205_8 = arg_202_1:FormatText(var_205_7.content)

				arg_202_1.text_.text = var_205_8

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_10 = 19 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_8) / 19)

				if (19 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_8) / 19)) > 0 and var_205_6 < var_205_10 then
					arg_202_1.talkMaxDuration = var_205_10

					if var_205_10 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_5
					end
				end

				arg_202_1.text_.text = var_205_8
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601049", "story_v_out_910601.awb") ~= 0 then
					local var_205_11 = manager.audio:GetVoiceLength("story_v_out_910601", "910601049", "story_v_out_910601.awb") / 1000

					if var_205_11 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_11 + var_205_5
					end

					if var_205_7.prefab_name ~= "" and arg_202_1.actors_[var_205_7.prefab_name] ~= nil then
						local var_205_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_7.prefab_name].transform, "story_v_out_910601", "910601049", "story_v_out_910601.awb")

						arg_202_1:RecordAudio("910601049", var_205_12)
						arg_202_1:RecordAudio("910601049", var_205_12)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_910601", "910601049", "story_v_out_910601.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_910601", "910601049", "story_v_out_910601.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_13 = math.max(var_205_6, arg_202_1.talkMaxDuration)

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_13 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_5) / var_205_13

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_5 + var_205_13 and arg_202_1.time_ < var_205_5 + var_205_13 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play910601050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 910601050
		arg_206_1.duration_ = 6.23

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play910601051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1048ui_story = arg_206_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1048ui_story"].transform.position).z)
				arg_206_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1048ui_story"].transform.localEulerAngles = arg_206_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_206_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1048ui_story"].transform.position).z)
				arg_206_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1048ui_story"].transform.localEulerAngles = arg_206_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1048ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1048ui_story == nil then
				arg_206_1.var_.characterEffect1048ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect1048ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1048ui_story then
				arg_206_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action7_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_209_4 = arg_206_1.actors_["1011ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1011ui_story = var_209_4.localPosition
			end

			local var_209_5 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_5 then
				var_209_4.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_5)
				var_209_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_4.position).x, (manager.ui.mainCamera.transform.position - var_209_4.position).y, (manager.ui.mainCamera.transform.position - var_209_4.position).z)
				var_209_4.localEulerAngles.z = 0
				var_209_4.localEulerAngles.x = 0
				var_209_4.localEulerAngles = var_209_4.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_5 and arg_206_1.time_ < 0 + var_209_5 + arg_209_0 then
				var_209_4.localPosition = Vector3.New(0, 100, 0)
				var_209_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_4.position).x, (manager.ui.mainCamera.transform.position - var_209_4.position).y, (manager.ui.mainCamera.transform.position - var_209_4.position).z)
				var_209_4.localEulerAngles.z = 0
				var_209_4.localEulerAngles.x = 0
				var_209_4.localEulerAngles = var_209_4.localEulerAngles
			end

			local var_209_6 = arg_206_1.actors_["1011ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_6) and arg_206_1.var_.characterEffect1011ui_story == nil then
				arg_206_1.var_.characterEffect1011ui_story = var_209_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_7 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 and not isNil(var_209_6) then
				if arg_206_1.var_.characterEffect1011ui_story and not isNil(var_209_6) then
					arg_206_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_7)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 and not isNil(var_209_6) and arg_206_1.var_.characterEffect1011ui_story then
				arg_206_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_209_8 = arg_206_1.actors_["1084ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1084ui_story = var_209_8.localPosition
			end

			local var_209_9 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_9 then
				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_9)
				var_209_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_8.position).x, (manager.ui.mainCamera.transform.position - var_209_8.position).y, (manager.ui.mainCamera.transform.position - var_209_8.position).z)
				var_209_8.localEulerAngles.z = 0
				var_209_8.localEulerAngles.x = 0
				var_209_8.localEulerAngles = var_209_8.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_9 and arg_206_1.time_ < 0 + var_209_9 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(0, 100, 0)
				var_209_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_8.position).x, (manager.ui.mainCamera.transform.position - var_209_8.position).y, (manager.ui.mainCamera.transform.position - var_209_8.position).z)
				var_209_8.localEulerAngles.z = 0
				var_209_8.localEulerAngles.x = 0
				var_209_8.localEulerAngles = var_209_8.localEulerAngles
			end

			local var_209_10 = arg_206_1.actors_["1084ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_10) and arg_206_1.var_.characterEffect1084ui_story == nil then
				arg_206_1.var_.characterEffect1084ui_story = var_209_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_11 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_11 and not isNil(var_209_10) then
				if arg_206_1.var_.characterEffect1084ui_story and not isNil(var_209_10) then
					arg_206_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_11)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_11 and arg_206_1.time_ < 0 + var_209_11 + arg_209_0 and not isNil(var_209_10) and arg_206_1.var_.characterEffect1084ui_story then
				arg_206_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_209_12 = 0
			local var_209_13 = 0.55

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_12 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_14 = arg_206_1:GetWordFromCfg(910601050)
				local var_209_15 = arg_206_1:FormatText(var_209_14.content)

				arg_206_1.text_.text = var_209_15

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_17 = 22 <= 0 and var_209_13 or var_209_13 * (utf8.len(var_209_15) / 22)

				if (22 <= 0 and var_209_13 or var_209_13 * (utf8.len(var_209_15) / 22)) > 0 and var_209_13 < var_209_17 then
					arg_206_1.talkMaxDuration = var_209_17

					if var_209_17 + var_209_12 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_17 + var_209_12
					end
				end

				arg_206_1.text_.text = var_209_15
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601050", "story_v_out_910601.awb") ~= 0 then
					local var_209_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601050", "story_v_out_910601.awb") / 1000

					if var_209_18 + var_209_12 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_18 + var_209_12
					end

					if var_209_14.prefab_name ~= "" and arg_206_1.actors_[var_209_14.prefab_name] ~= nil then
						local var_209_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_14.prefab_name].transform, "story_v_out_910601", "910601050", "story_v_out_910601.awb")

						arg_206_1:RecordAudio("910601050", var_209_19)
						arg_206_1:RecordAudio("910601050", var_209_19)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_910601", "910601050", "story_v_out_910601.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_910601", "910601050", "story_v_out_910601.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_20 = math.max(var_209_13, arg_206_1.talkMaxDuration)

			if var_209_12 <= arg_206_1.time_ and arg_206_1.time_ < var_209_12 + var_209_20 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_12) / var_209_20

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_12 + var_209_20 and arg_206_1.time_ < var_209_12 + var_209_20 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play910601051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 910601051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play910601052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1048ui_story"]) and arg_210_1.var_.characterEffect1048ui_story == nil then
				arg_210_1.var_.characterEffect1048ui_story = arg_210_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1048ui_story"]) then
				if arg_210_1.var_.characterEffect1048ui_story and not isNil(arg_210_1.actors_["1048ui_story"]) then
					arg_210_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_0)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1048ui_story"]) and arg_210_1.var_.characterEffect1048ui_story then
				arg_210_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_213_1 = arg_210_1.actors_["1048ui_story"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1048ui_story = var_213_1.localPosition
			end

			local var_213_2 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_2)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0, 100, 0)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			local var_213_3 = 0
			local var_213_4 = 0.525

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_3 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_5 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(910601051).content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 21 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_5) / 21)

				if (21 <= 0 and var_213_4 or var_213_4 * (utf8.len(var_213_5) / 21)) > 0 and var_213_4 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_3 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_3
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_8 = math.max(var_213_4, arg_210_1.talkMaxDuration)

			if var_213_3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_3 + var_213_8 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_3) / var_213_8

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_3 + var_213_8 and arg_210_1.time_ < var_213_3 + var_213_8 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play910601052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 910601052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play910601053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 1

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(910601052).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 40 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 40)

				if (40 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 40)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play910601053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 910601053
		arg_218_1.duration_ = 3.3

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play910601054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1028ui_story = arg_218_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1028ui_story"].transform.position).z)
				arg_218_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1028ui_story"].transform.localEulerAngles = arg_218_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, -0.9, -5.9)
				arg_218_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1028ui_story"].transform.position).z)
				arg_218_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1028ui_story"].transform.localEulerAngles = arg_218_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["1028ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1028ui_story == nil then
				arg_218_1.var_.characterEffect1028ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1028ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1028ui_story then
				arg_218_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_221_4 = 0
			local var_221_5 = 0.4

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(910601053)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)

				if (16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601053", "story_v_out_910601.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601053", "story_v_out_910601.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_910601", "910601053", "story_v_out_910601.awb")

						arg_218_1:RecordAudio("910601053", var_221_11)
						arg_218_1:RecordAudio("910601053", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_910601", "910601053", "story_v_out_910601.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_910601", "910601053", "story_v_out_910601.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play910601054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 910601054
		arg_222_1.duration_ = 4.67

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play910601055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1059ui_story = arg_222_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).z)
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles = arg_222_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_222_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1059ui_story"].transform.position).z)
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1059ui_story"].transform.localEulerAngles = arg_222_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1059ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1059ui_story == nil then
				arg_222_1.var_.characterEffect1059ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1059ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1059ui_story then
				arg_222_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_225_4 = arg_222_1.actors_["1028ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1028ui_story = var_225_4.localPosition
			end

			local var_225_5 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_5 then
				var_225_4.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_5)
				var_225_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_4.position).x, (manager.ui.mainCamera.transform.position - var_225_4.position).y, (manager.ui.mainCamera.transform.position - var_225_4.position).z)
				var_225_4.localEulerAngles.z = 0
				var_225_4.localEulerAngles.x = 0
				var_225_4.localEulerAngles = var_225_4.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_5 and arg_222_1.time_ < 0 + var_225_5 + arg_225_0 then
				var_225_4.localPosition = Vector3.New(0, 100, 0)
				var_225_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_4.position).x, (manager.ui.mainCamera.transform.position - var_225_4.position).y, (manager.ui.mainCamera.transform.position - var_225_4.position).z)
				var_225_4.localEulerAngles.z = 0
				var_225_4.localEulerAngles.x = 0
				var_225_4.localEulerAngles = var_225_4.localEulerAngles
			end

			local var_225_6 = arg_222_1.actors_["1028ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_6) and arg_222_1.var_.characterEffect1028ui_story == nil then
				arg_222_1.var_.characterEffect1028ui_story = var_225_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_7 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 and not isNil(var_225_6) then
				if arg_222_1.var_.characterEffect1028ui_story and not isNil(var_225_6) then
					arg_222_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_7)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 and not isNil(var_225_6) and arg_222_1.var_.characterEffect1028ui_story then
				arg_222_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_225_8 = arg_222_1.actors_["1048ui_story"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1048ui_story = var_225_8.localPosition
			end

			local var_225_9 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_9 then
				var_225_8.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_222_1.time_ - 0) / var_225_9)
				var_225_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_8.position).x, (manager.ui.mainCamera.transform.position - var_225_8.position).y, (manager.ui.mainCamera.transform.position - var_225_8.position).z)
				var_225_8.localEulerAngles.z = 0
				var_225_8.localEulerAngles.x = 0
				var_225_8.localEulerAngles = var_225_8.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_9 and arg_222_1.time_ < 0 + var_225_9 + arg_225_0 then
				var_225_8.localPosition = Vector3.New(0, 100, 0)
				var_225_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_225_8.position).x, (manager.ui.mainCamera.transform.position - var_225_8.position).y, (manager.ui.mainCamera.transform.position - var_225_8.position).z)
				var_225_8.localEulerAngles.z = 0
				var_225_8.localEulerAngles.x = 0
				var_225_8.localEulerAngles = var_225_8.localEulerAngles
			end

			local var_225_10 = arg_222_1.actors_["1048ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_10) and arg_222_1.var_.characterEffect1048ui_story == nil then
				arg_222_1.var_.characterEffect1048ui_story = var_225_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_11 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_11 and not isNil(var_225_10) then
				if arg_222_1.var_.characterEffect1048ui_story and not isNil(var_225_10) then
					arg_222_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_11)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_11 and arg_222_1.time_ < 0 + var_225_11 + arg_225_0 and not isNil(var_225_10) and arg_222_1.var_.characterEffect1048ui_story then
				arg_222_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_225_12 = 0
			local var_225_13 = 0.45

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_14 = arg_222_1:GetWordFromCfg(910601054)
				local var_225_15 = arg_222_1:FormatText(var_225_14.content)

				arg_222_1.text_.text = var_225_15

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_17 = 18 <= 0 and var_225_13 or var_225_13 * (utf8.len(var_225_15) / 18)

				if (18 <= 0 and var_225_13 or var_225_13 * (utf8.len(var_225_15) / 18)) > 0 and var_225_13 < var_225_17 then
					arg_222_1.talkMaxDuration = var_225_17

					if var_225_17 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_12
					end
				end

				arg_222_1.text_.text = var_225_15
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601054", "story_v_out_910601.awb") ~= 0 then
					local var_225_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601054", "story_v_out_910601.awb") / 1000

					if var_225_18 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_18 + var_225_12
					end

					if var_225_14.prefab_name ~= "" and arg_222_1.actors_[var_225_14.prefab_name] ~= nil then
						local var_225_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_14.prefab_name].transform, "story_v_out_910601", "910601054", "story_v_out_910601.awb")

						arg_222_1:RecordAudio("910601054", var_225_19)
						arg_222_1:RecordAudio("910601054", var_225_19)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_910601", "910601054", "story_v_out_910601.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_910601", "910601054", "story_v_out_910601.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_20 = math.max(var_225_13, arg_222_1.talkMaxDuration)

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_20 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_12) / var_225_20

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_12 + var_225_20 and arg_222_1.time_ < var_225_12 + var_225_20 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play910601055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 910601055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play910601056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1059ui_story"]) and arg_226_1.var_.characterEffect1059ui_story == nil then
				arg_226_1.var_.characterEffect1059ui_story = arg_226_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1059ui_story"]) then
				if arg_226_1.var_.characterEffect1059ui_story and not isNil(arg_226_1.actors_["1059ui_story"]) then
					arg_226_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1059ui_story"]) and arg_226_1.var_.characterEffect1059ui_story then
				arg_226_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.375

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(910601055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 15 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 15)

				if (15 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 15)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play910601056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 910601056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play910601057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1059ui_story = arg_230_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1059ui_story"].transform.position).z)
				arg_230_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1059ui_story"].transform.localEulerAngles = arg_230_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1059ui_story"].transform.position).z)
				arg_230_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1059ui_story"].transform.localEulerAngles = arg_230_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_233_1 = 0
			local var_233_2 = 1.075

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(910601056).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 43 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 43)

				if (43 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 43)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play910601057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 910601057
		arg_234_1.duration_ = 5.73

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play910601058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1048ui_story = arg_234_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1048ui_story"].transform.position).z)
				arg_234_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1048ui_story"].transform.localEulerAngles = arg_234_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_234_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1048ui_story"].transform.position).z)
				arg_234_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1048ui_story"].transform.localEulerAngles = arg_234_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1048ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1048ui_story == nil then
				arg_234_1.var_.characterEffect1048ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1048ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1048ui_story then
				arg_234_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_237_4 = 0
			local var_237_5 = 0.6

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(910601057)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 24 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 24)

				if (24 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 24)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601057", "story_v_out_910601.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601057", "story_v_out_910601.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_910601", "910601057", "story_v_out_910601.awb")

						arg_234_1:RecordAudio("910601057", var_237_11)
						arg_234_1:RecordAudio("910601057", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_910601", "910601057", "story_v_out_910601.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_910601", "910601057", "story_v_out_910601.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play910601058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 910601058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play910601059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1048ui_story"]) and arg_238_1.var_.characterEffect1048ui_story == nil then
				arg_238_1.var_.characterEffect1048ui_story = arg_238_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1048ui_story"]) then
				if arg_238_1.var_.characterEffect1048ui_story and not isNil(arg_238_1.actors_["1048ui_story"]) then
					arg_238_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1048ui_story"]) and arg_238_1.var_.characterEffect1048ui_story then
				arg_238_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.4

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(910601058).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 16 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 16)

				if (16 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 16)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play910601059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 910601059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play910601060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.275

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(910601059).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 11 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 11)

				if (11 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 11)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play910601060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 910601060
		arg_246_1.duration_ = 7.73

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play910601061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1048ui_story = arg_246_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1048ui_story"].transform.position).z)
				arg_246_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1048ui_story"].transform.localEulerAngles = arg_246_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_246_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1048ui_story"].transform.position).z)
				arg_246_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1048ui_story"].transform.localEulerAngles = arg_246_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["1048ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1048ui_story == nil then
				arg_246_1.var_.characterEffect1048ui_story = var_249_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 and not isNil(var_249_1) then
				if arg_246_1.var_.characterEffect1048ui_story and not isNil(var_249_1) then
					arg_246_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1048ui_story then
				arg_246_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_249_4 = 0
			local var_249_5 = 0.95

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_6 = arg_246_1:GetWordFromCfg(910601060)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 38 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 38)

				if (38 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 38)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601060", "story_v_out_910601.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601060", "story_v_out_910601.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_out_910601", "910601060", "story_v_out_910601.awb")

						arg_246_1:RecordAudio("910601060", var_249_11)
						arg_246_1:RecordAudio("910601060", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_910601", "910601060", "story_v_out_910601.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_910601", "910601060", "story_v_out_910601.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_5, arg_246_1.talkMaxDuration)

			if var_249_4 <= arg_246_1.time_ and arg_246_1.time_ < var_249_4 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_4) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_4 + var_249_12 and arg_246_1.time_ < var_249_4 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play910601061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 910601061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play910601062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1048ui_story"]) and arg_250_1.var_.characterEffect1048ui_story == nil then
				arg_250_1.var_.characterEffect1048ui_story = arg_250_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1048ui_story"]) then
				if arg_250_1.var_.characterEffect1048ui_story and not isNil(arg_250_1.actors_["1048ui_story"]) then
					arg_250_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1048ui_story"]) and arg_250_1.var_.characterEffect1048ui_story then
				arg_250_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_253_1 = 0
			local var_253_2 = 0.55

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(910601061).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 22 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 22)

				if (22 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 22)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play910601062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 910601062
		arg_254_1.duration_ = 2.47

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play910601063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1048ui_story = arg_254_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1048ui_story"].transform.position).z)
				arg_254_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1048ui_story"].transform.localEulerAngles = arg_254_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_254_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1048ui_story"].transform.position).z)
				arg_254_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1048ui_story"].transform.localEulerAngles = arg_254_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1048ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1048ui_story == nil then
				arg_254_1.var_.characterEffect1048ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect1048ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1048ui_story then
				arg_254_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action453")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_257_4 = 0
			local var_257_5 = 0.275

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(910601062)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 11 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 11)

				if (11 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 11)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601062", "story_v_out_910601.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601062", "story_v_out_910601.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_out_910601", "910601062", "story_v_out_910601.awb")

						arg_254_1:RecordAudio("910601062", var_257_11)
						arg_254_1:RecordAudio("910601062", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_910601", "910601062", "story_v_out_910601.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_910601", "910601062", "story_v_out_910601.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play910601063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 910601063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play910601064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1048ui_story"]) and arg_258_1.var_.characterEffect1048ui_story == nil then
				arg_258_1.var_.characterEffect1048ui_story = arg_258_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1048ui_story"]) then
				if arg_258_1.var_.characterEffect1048ui_story and not isNil(arg_258_1.actors_["1048ui_story"]) then
					arg_258_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1048ui_story"]) and arg_258_1.var_.characterEffect1048ui_story then
				arg_258_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_261_1 = 0
			local var_261_2 = 0.05

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(910601063).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 2 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 2)

				if (2 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 2)) > 0 and var_261_2 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_1 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_1
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_6 = math.max(var_261_2, arg_258_1.talkMaxDuration)

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_6 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_1) / var_261_6

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_1 + var_261_6 and arg_258_1.time_ < var_261_1 + var_261_6 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play910601064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 910601064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play910601065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.4

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(910601064).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 16 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 16)

				if (16 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 16)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play910601065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 910601065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play910601066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.725

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(910601065).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 29 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 29)

				if (29 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 29)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play910601066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 910601066
		arg_270_1.duration_ = 6.8

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play910601067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1028ui_story = arg_270_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1028ui_story"].transform.position).z)
				arg_270_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1028ui_story"].transform.localEulerAngles = arg_270_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -5.9)
				arg_270_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1028ui_story"].transform.position).z)
				arg_270_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1028ui_story"].transform.localEulerAngles = arg_270_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["1028ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1028ui_story == nil then
				arg_270_1.var_.characterEffect1028ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect1028ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1028ui_story then
				arg_270_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action5_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_273_4 = arg_270_1.actors_["1048ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1048ui_story = var_273_4.localPosition
			end

			local var_273_5 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_5 then
				var_273_4.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_270_1.time_ - 0) / var_273_5)
				var_273_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_4.position).x, (manager.ui.mainCamera.transform.position - var_273_4.position).y, (manager.ui.mainCamera.transform.position - var_273_4.position).z)
				var_273_4.localEulerAngles.z = 0
				var_273_4.localEulerAngles.x = 0
				var_273_4.localEulerAngles = var_273_4.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_5 and arg_270_1.time_ < 0 + var_273_5 + arg_273_0 then
				var_273_4.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_273_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_4.position).x, (manager.ui.mainCamera.transform.position - var_273_4.position).y, (manager.ui.mainCamera.transform.position - var_273_4.position).z)
				var_273_4.localEulerAngles.z = 0
				var_273_4.localEulerAngles.x = 0
				var_273_4.localEulerAngles = var_273_4.localEulerAngles
			end

			local var_273_6 = arg_270_1.actors_["1048ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_6) and arg_270_1.var_.characterEffect1048ui_story == nil then
				arg_270_1.var_.characterEffect1048ui_story = var_273_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_7 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 and not isNil(var_273_6) then
				if arg_270_1.var_.characterEffect1048ui_story and not isNil(var_273_6) then
					arg_270_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_7)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 and not isNil(var_273_6) and arg_270_1.var_.characterEffect1048ui_story then
				arg_270_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_2")
			end

			local var_273_8 = 0
			local var_273_9 = 0.625

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_10 = arg_270_1:GetWordFromCfg(910601066)
				local var_273_11 = arg_270_1:FormatText(var_273_10.content)

				arg_270_1.text_.text = var_273_11

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 25 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 25)

				if (25 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 25)) > 0 and var_273_9 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_8
					end
				end

				arg_270_1.text_.text = var_273_11
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601066", "story_v_out_910601.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601066", "story_v_out_910601.awb") / 1000

					if var_273_14 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_8
					end

					if var_273_10.prefab_name ~= "" and arg_270_1.actors_[var_273_10.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_10.prefab_name].transform, "story_v_out_910601", "910601066", "story_v_out_910601.awb")

						arg_270_1:RecordAudio("910601066", var_273_15)
						arg_270_1:RecordAudio("910601066", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_910601", "910601066", "story_v_out_910601.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_910601", "910601066", "story_v_out_910601.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_9, arg_270_1.talkMaxDuration)

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_8) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_8 + var_273_16 and arg_270_1.time_ < var_273_8 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play910601067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 910601067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play910601068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1028ui_story"]) and arg_274_1.var_.characterEffect1028ui_story == nil then
				arg_274_1.var_.characterEffect1028ui_story = arg_274_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1028ui_story"]) then
				if arg_274_1.var_.characterEffect1028ui_story and not isNil(arg_274_1.actors_["1028ui_story"]) then
					arg_274_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1028ui_story"]) and arg_274_1.var_.characterEffect1028ui_story then
				arg_274_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 1.325

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(910601067).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 53 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 53)

				if (53 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 53)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play910601068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 910601068
		arg_278_1.duration_ = 1

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"

			SetActive(arg_278_1.choicesGo_, true)

			for iter_279_0, iter_279_1 in ipairs(arg_278_1.choices_) do
				SetActive(iter_279_1.go, iter_279_0 <= 2)
			end

			arg_278_1.choices_[1].txt.text = arg_278_1:FormatText(StoryChoiceCfg[692].name)
			arg_278_1.choices_[2].txt.text = arg_278_1:FormatText(StoryChoiceCfg[693].name)
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play910601069(arg_278_1)
			end

			if arg_280_0 == 2 then
				arg_278_0:Play910601072(arg_278_1)
			end

			arg_278_1:RecordChoiceLog(910601068, 692, 693)
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= 0 + 0.5 and arg_278_1.time_ < 0 + 0.5 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_0 = arg_278_1.actors_["1028ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1028ui_story = var_281_0.localPosition
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_1)
				var_281_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_0.position).x, (manager.ui.mainCamera.transform.position - var_281_0.position).y, (manager.ui.mainCamera.transform.position - var_281_0.position).z)
				var_281_0.localEulerAngles.z = 0
				var_281_0.localEulerAngles.x = 0
				var_281_0.localEulerAngles = var_281_0.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, 100, 0)
				var_281_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_0.position).x, (manager.ui.mainCamera.transform.position - var_281_0.position).y, (manager.ui.mainCamera.transform.position - var_281_0.position).z)
				var_281_0.localEulerAngles.z = 0
				var_281_0.localEulerAngles.x = 0
				var_281_0.localEulerAngles = var_281_0.localEulerAngles
			end

			local var_281_2 = arg_278_1.actors_["1048ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1048ui_story = var_281_2.localPosition
			end

			local var_281_3 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 then
				var_281_2.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_3)
				var_281_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_2.position).x, (manager.ui.mainCamera.transform.position - var_281_2.position).y, (manager.ui.mainCamera.transform.position - var_281_2.position).z)
				var_281_2.localEulerAngles.z = 0
				var_281_2.localEulerAngles.x = 0
				var_281_2.localEulerAngles = var_281_2.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 then
				var_281_2.localPosition = Vector3.New(0, 100, 0)
				var_281_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_2.position).x, (manager.ui.mainCamera.transform.position - var_281_2.position).y, (manager.ui.mainCamera.transform.position - var_281_2.position).z)
				var_281_2.localEulerAngles.z = 0
				var_281_2.localEulerAngles.x = 0
				var_281_2.localEulerAngles = var_281_2.localEulerAngles
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play910601069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 910601069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play910601070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.25

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(910601069).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 10 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 10)

				if (10 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 10)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play910601070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 910601070
		arg_286_1.duration_ = 4.47

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play910601071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1048ui_story = arg_286_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1048ui_story"].transform.position).z)
				arg_286_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1048ui_story"].transform.localEulerAngles = arg_286_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_286_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1048ui_story"].transform.position).z)
				arg_286_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1048ui_story"].transform.localEulerAngles = arg_286_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["1048ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1048ui_story == nil then
				arg_286_1.var_.characterEffect1048ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect1048ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1048ui_story then
				arg_286_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action4_1")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_289_4 = 0
			local var_289_5 = 0.45

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(910601070)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_9 = 18 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 18)

				if (18 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 18)) > 0 and var_289_5 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601070", "story_v_out_910601.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601070", "story_v_out_910601.awb") / 1000

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end

					if var_289_6.prefab_name ~= "" and arg_286_1.actors_[var_289_6.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_6.prefab_name].transform, "story_v_out_910601", "910601070", "story_v_out_910601.awb")

						arg_286_1:RecordAudio("910601070", var_289_11)
						arg_286_1:RecordAudio("910601070", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_910601", "910601070", "story_v_out_910601.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_910601", "910601070", "story_v_out_910601.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_12 and arg_286_1.time_ < var_289_4 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play910601071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 910601071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play910601075(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1048ui_story"]) and arg_290_1.var_.characterEffect1048ui_story == nil then
				arg_290_1.var_.characterEffect1048ui_story = arg_290_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1048ui_story"]) then
				if arg_290_1.var_.characterEffect1048ui_story and not isNil(arg_290_1.actors_["1048ui_story"]) then
					arg_290_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1048ui_story"]) and arg_290_1.var_.characterEffect1048ui_story then
				arg_290_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.5

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(910601071).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 20 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 20)

				if (20 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 20)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play910601075 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 910601075
		arg_294_1.duration_ = 2.33

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play910601076(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1028ui_story = arg_294_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1028ui_story"].transform.position).z)
				arg_294_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1028ui_story"].transform.localEulerAngles = arg_294_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -5.9)
				arg_294_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1028ui_story"].transform.position).z)
				arg_294_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1028ui_story"].transform.localEulerAngles = arg_294_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_297_1 = arg_294_1.actors_["1028ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect1028ui_story == nil then
				arg_294_1.var_.characterEffect1028ui_story = var_297_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_2 and not isNil(var_297_1) then
				if arg_294_1.var_.characterEffect1028ui_story and not isNil(var_297_1) then
					arg_294_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_2 and arg_294_1.time_ < 0 + var_297_2 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect1028ui_story then
				arg_294_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_297_4 = 0
			local var_297_5 = 0.2

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_6 = arg_294_1:GetWordFromCfg(910601075)
				local var_297_7 = arg_294_1:FormatText(var_297_6.content)

				arg_294_1.text_.text = var_297_7

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_9 = 8 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_7) / 8)

				if (8 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_7) / 8)) > 0 and var_297_5 < var_297_9 then
					arg_294_1.talkMaxDuration = var_297_9

					if var_297_9 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_9 + var_297_4
					end
				end

				arg_294_1.text_.text = var_297_7
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601075", "story_v_out_910601.awb") ~= 0 then
					local var_297_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601075", "story_v_out_910601.awb") / 1000

					if var_297_10 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_10 + var_297_4
					end

					if var_297_6.prefab_name ~= "" and arg_294_1.actors_[var_297_6.prefab_name] ~= nil then
						local var_297_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_6.prefab_name].transform, "story_v_out_910601", "910601075", "story_v_out_910601.awb")

						arg_294_1:RecordAudio("910601075", var_297_11)
						arg_294_1:RecordAudio("910601075", var_297_11)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_910601", "910601075", "story_v_out_910601.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_910601", "910601075", "story_v_out_910601.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_12 = math.max(var_297_5, arg_294_1.talkMaxDuration)

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_12 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_4) / var_297_12

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_4 + var_297_12 and arg_294_1.time_ < var_297_4 + var_297_12 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play910601076 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 910601076
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play910601077(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1028ui_story"]) and arg_298_1.var_.characterEffect1028ui_story == nil then
				arg_298_1.var_.characterEffect1028ui_story = arg_298_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1028ui_story"]) then
				if arg_298_1.var_.characterEffect1028ui_story and not isNil(arg_298_1.actors_["1028ui_story"]) then
					arg_298_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_0)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1028ui_story"]) and arg_298_1.var_.characterEffect1028ui_story then
				arg_298_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_301_1 = arg_298_1.actors_["1048ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1048ui_story = var_301_1.localPosition
			end

			local var_301_2 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_2 then
				var_301_1.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_2)
				var_301_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_1.position).x, (manager.ui.mainCamera.transform.position - var_301_1.position).y, (manager.ui.mainCamera.transform.position - var_301_1.position).z)
				var_301_1.localEulerAngles.z = 0
				var_301_1.localEulerAngles.x = 0
				var_301_1.localEulerAngles = var_301_1.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_2 and arg_298_1.time_ < 0 + var_301_2 + arg_301_0 then
				var_301_1.localPosition = Vector3.New(0, 100, 0)
				var_301_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_1.position).x, (manager.ui.mainCamera.transform.position - var_301_1.position).y, (manager.ui.mainCamera.transform.position - var_301_1.position).z)
				var_301_1.localEulerAngles.z = 0
				var_301_1.localEulerAngles.x = 0
				var_301_1.localEulerAngles = var_301_1.localEulerAngles
			end

			local var_301_3 = arg_298_1.actors_["1028ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1028ui_story = var_301_3.localPosition
			end

			local var_301_4 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				var_301_3.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_4)
				var_301_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_3.position).x, (manager.ui.mainCamera.transform.position - var_301_3.position).y, (manager.ui.mainCamera.transform.position - var_301_3.position).z)
				var_301_3.localEulerAngles.z = 0
				var_301_3.localEulerAngles.x = 0
				var_301_3.localEulerAngles = var_301_3.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				var_301_3.localPosition = Vector3.New(0, 100, 0)
				var_301_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_3.position).x, (manager.ui.mainCamera.transform.position - var_301_3.position).y, (manager.ui.mainCamera.transform.position - var_301_3.position).z)
				var_301_3.localEulerAngles.z = 0
				var_301_3.localEulerAngles.x = 0
				var_301_3.localEulerAngles = var_301_3.localEulerAngles
			end

			local var_301_5 = 0
			local var_301_6 = 0.725

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_7 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(910601076).content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 29 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_7) / 29)

				if (29 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_7) / 29)) > 0 and var_301_6 < var_301_9 then
					arg_298_1.talkMaxDuration = var_301_9

					if var_301_9 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_9 + var_301_5
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_6, arg_298_1.talkMaxDuration)

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_5) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_5 + var_301_10 and arg_298_1.time_ < var_301_5 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play910601077 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 910601077
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play910601078(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.375

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(910601077).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 15 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 15)

				if (15 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 15)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play910601078 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 910601078
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play910601079(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.7

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(910601078).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 28 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 28)

				if (28 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 28)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play910601079 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 910601079
		arg_310_1.duration_ = 3.53

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play910601080(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1084ui_story = arg_310_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1084ui_story"].transform.position).z)
				arg_310_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1084ui_story"].transform.localEulerAngles = arg_310_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_310_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1084ui_story"].transform.position).z)
				arg_310_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1084ui_story"].transform.localEulerAngles = arg_310_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_313_1 = arg_310_1.actors_["1084ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1084ui_story == nil then
				arg_310_1.var_.characterEffect1084ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_2 and not isNil(var_313_1) then
				if arg_310_1.var_.characterEffect1084ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_2 and arg_310_1.time_ < 0 + var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1084ui_story then
				arg_310_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_313_4 = arg_310_1.actors_["1028ui_story"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1028ui_story = var_313_4.localPosition
			end

			local var_313_5 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_5 then
				var_313_4.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_310_1.time_ - 0) / var_313_5)
				var_313_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_4.position).x, (manager.ui.mainCamera.transform.position - var_313_4.position).y, (manager.ui.mainCamera.transform.position - var_313_4.position).z)
				var_313_4.localEulerAngles.z = 0
				var_313_4.localEulerAngles.x = 0
				var_313_4.localEulerAngles = var_313_4.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_5 and arg_310_1.time_ < 0 + var_313_5 + arg_313_0 then
				var_313_4.localPosition = Vector3.New(0, 100, 0)
				var_313_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_4.position).x, (manager.ui.mainCamera.transform.position - var_313_4.position).y, (manager.ui.mainCamera.transform.position - var_313_4.position).z)
				var_313_4.localEulerAngles.z = 0
				var_313_4.localEulerAngles.x = 0
				var_313_4.localEulerAngles = var_313_4.localEulerAngles
			end

			local var_313_6 = arg_310_1.actors_["1028ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_6) and arg_310_1.var_.characterEffect1028ui_story == nil then
				arg_310_1.var_.characterEffect1028ui_story = var_313_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_7 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 and not isNil(var_313_6) then
				if arg_310_1.var_.characterEffect1028ui_story and not isNil(var_313_6) then
					arg_310_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_7)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 and not isNil(var_313_6) and arg_310_1.var_.characterEffect1028ui_story then
				arg_310_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_313_8 = arg_310_1.actors_["1048ui_story"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1048ui_story = var_313_8.localPosition
			end

			local var_313_9 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_9 then
				var_313_8.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_310_1.time_ - 0) / var_313_9)
				var_313_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_8.position).x, (manager.ui.mainCamera.transform.position - var_313_8.position).y, (manager.ui.mainCamera.transform.position - var_313_8.position).z)
				var_313_8.localEulerAngles.z = 0
				var_313_8.localEulerAngles.x = 0
				var_313_8.localEulerAngles = var_313_8.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_9 and arg_310_1.time_ < 0 + var_313_9 + arg_313_0 then
				var_313_8.localPosition = Vector3.New(0, 100, 0)
				var_313_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_8.position).x, (manager.ui.mainCamera.transform.position - var_313_8.position).y, (manager.ui.mainCamera.transform.position - var_313_8.position).z)
				var_313_8.localEulerAngles.z = 0
				var_313_8.localEulerAngles.x = 0
				var_313_8.localEulerAngles = var_313_8.localEulerAngles
			end

			local var_313_10 = arg_310_1.actors_["1048ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_10) and arg_310_1.var_.characterEffect1048ui_story == nil then
				arg_310_1.var_.characterEffect1048ui_story = var_313_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_11 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_11 and not isNil(var_313_10) then
				if arg_310_1.var_.characterEffect1048ui_story and not isNil(var_313_10) then
					arg_310_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_11)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_11 and arg_310_1.time_ < 0 + var_313_11 + arg_313_0 and not isNil(var_313_10) and arg_310_1.var_.characterEffect1048ui_story then
				arg_310_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_313_12 = 0
			local var_313_13 = 0.125

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_12 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_14 = arg_310_1:GetWordFromCfg(910601079)
				local var_313_15 = arg_310_1:FormatText(var_313_14.content)

				arg_310_1.text_.text = var_313_15

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_17 = 5 <= 0 and var_313_13 or var_313_13 * (utf8.len(var_313_15) / 5)

				if (5 <= 0 and var_313_13 or var_313_13 * (utf8.len(var_313_15) / 5)) > 0 and var_313_13 < var_313_17 then
					arg_310_1.talkMaxDuration = var_313_17

					if var_313_17 + var_313_12 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_17 + var_313_12
					end
				end

				arg_310_1.text_.text = var_313_15
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601079", "story_v_out_910601.awb") ~= 0 then
					local var_313_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601079", "story_v_out_910601.awb") / 1000

					if var_313_18 + var_313_12 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_18 + var_313_12
					end

					if var_313_14.prefab_name ~= "" and arg_310_1.actors_[var_313_14.prefab_name] ~= nil then
						local var_313_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_14.prefab_name].transform, "story_v_out_910601", "910601079", "story_v_out_910601.awb")

						arg_310_1:RecordAudio("910601079", var_313_19)
						arg_310_1:RecordAudio("910601079", var_313_19)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_910601", "910601079", "story_v_out_910601.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_910601", "910601079", "story_v_out_910601.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_20 = math.max(var_313_13, arg_310_1.talkMaxDuration)

			if var_313_12 <= arg_310_1.time_ and arg_310_1.time_ < var_313_12 + var_313_20 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_12) / var_313_20

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_12 + var_313_20 and arg_310_1.time_ < var_313_12 + var_313_20 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play910601080 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 910601080
		arg_314_1.duration_ = 9.13

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play910601081(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos1048ui_story = arg_314_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_317_0 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 then
				arg_314_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_314_1.time_ - 0) / var_317_0)
				arg_314_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1048ui_story"].transform.position).z)
				arg_314_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1048ui_story"].transform.localEulerAngles = arg_314_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_314_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1048ui_story"].transform.position).z)
				arg_314_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1048ui_story"].transform.localEulerAngles = arg_314_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_317_1 = arg_314_1.actors_["1048ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1048ui_story == nil then
				arg_314_1.var_.characterEffect1048ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_2 and not isNil(var_317_1) then
				if arg_314_1.var_.characterEffect1048ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_2 and arg_314_1.time_ < 0 + var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1048ui_story then
				arg_314_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_317_4 = arg_314_1.actors_["1084ui_story"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos1084ui_story = var_317_4.localPosition
			end

			local var_317_5 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_5 then
				var_317_4.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_314_1.time_ - 0) / var_317_5)
				var_317_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_4.position).x, (manager.ui.mainCamera.transform.position - var_317_4.position).y, (manager.ui.mainCamera.transform.position - var_317_4.position).z)
				var_317_4.localEulerAngles.z = 0
				var_317_4.localEulerAngles.x = 0
				var_317_4.localEulerAngles = var_317_4.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_5 and arg_314_1.time_ < 0 + var_317_5 + arg_317_0 then
				var_317_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_317_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_317_4.position).x, (manager.ui.mainCamera.transform.position - var_317_4.position).y, (manager.ui.mainCamera.transform.position - var_317_4.position).z)
				var_317_4.localEulerAngles.z = 0
				var_317_4.localEulerAngles.x = 0
				var_317_4.localEulerAngles = var_317_4.localEulerAngles
			end

			local var_317_6 = arg_314_1.actors_["1084ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_6) and arg_314_1.var_.characterEffect1084ui_story == nil then
				arg_314_1.var_.characterEffect1084ui_story = var_317_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_7 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 and not isNil(var_317_6) then
				if arg_314_1.var_.characterEffect1084ui_story and not isNil(var_317_6) then
					arg_314_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_7)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 and not isNil(var_317_6) and arg_314_1.var_.characterEffect1084ui_story then
				arg_314_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_317_8 = 0
			local var_317_9 = 0.9

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_8 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_10 = arg_314_1:GetWordFromCfg(910601080)
				local var_317_11 = arg_314_1:FormatText(var_317_10.content)

				arg_314_1.text_.text = var_317_11

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_13 = 36 <= 0 and var_317_9 or var_317_9 * (utf8.len(var_317_11) / 36)

				if (36 <= 0 and var_317_9 or var_317_9 * (utf8.len(var_317_11) / 36)) > 0 and var_317_9 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_8
					end
				end

				arg_314_1.text_.text = var_317_11
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601080", "story_v_out_910601.awb") ~= 0 then
					local var_317_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601080", "story_v_out_910601.awb") / 1000

					if var_317_14 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_8
					end

					if var_317_10.prefab_name ~= "" and arg_314_1.actors_[var_317_10.prefab_name] ~= nil then
						local var_317_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_10.prefab_name].transform, "story_v_out_910601", "910601080", "story_v_out_910601.awb")

						arg_314_1:RecordAudio("910601080", var_317_15)
						arg_314_1:RecordAudio("910601080", var_317_15)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_910601", "910601080", "story_v_out_910601.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_910601", "910601080", "story_v_out_910601.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_9, arg_314_1.talkMaxDuration)

			if var_317_8 <= arg_314_1.time_ and arg_314_1.time_ < var_317_8 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_8) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_8 + var_317_16 and arg_314_1.time_ < var_317_8 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play910601081 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 910601081
		arg_318_1.duration_ = 7.4

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play910601082(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1011ui_story = arg_318_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1011ui_story"].transform.position).z)
				arg_318_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1011ui_story"].transform.localEulerAngles = arg_318_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_318_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1011ui_story"].transform.position).z)
				arg_318_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1011ui_story"].transform.localEulerAngles = arg_318_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_321_1 = arg_318_1.actors_["1011ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect1011ui_story == nil then
				arg_318_1.var_.characterEffect1011ui_story = var_321_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_2 and not isNil(var_321_1) then
				if arg_318_1.var_.characterEffect1011ui_story and not isNil(var_321_1) then
					arg_318_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_2 and arg_318_1.time_ < 0 + var_321_2 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect1011ui_story then
				arg_318_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_321_4 = arg_318_1.actors_["1048ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1048ui_story = var_321_4.localPosition
			end

			local var_321_5 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_5 then
				var_321_4.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_318_1.time_ - 0) / var_321_5)
				var_321_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_4.position).x, (manager.ui.mainCamera.transform.position - var_321_4.position).y, (manager.ui.mainCamera.transform.position - var_321_4.position).z)
				var_321_4.localEulerAngles.z = 0
				var_321_4.localEulerAngles.x = 0
				var_321_4.localEulerAngles = var_321_4.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_5 and arg_318_1.time_ < 0 + var_321_5 + arg_321_0 then
				var_321_4.localPosition = Vector3.New(0, 100, 0)
				var_321_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_4.position).x, (manager.ui.mainCamera.transform.position - var_321_4.position).y, (manager.ui.mainCamera.transform.position - var_321_4.position).z)
				var_321_4.localEulerAngles.z = 0
				var_321_4.localEulerAngles.x = 0
				var_321_4.localEulerAngles = var_321_4.localEulerAngles
			end

			local var_321_6 = arg_318_1.actors_["1048ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_6) and arg_318_1.var_.characterEffect1048ui_story == nil then
				arg_318_1.var_.characterEffect1048ui_story = var_321_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_7 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 and not isNil(var_321_6) then
				if arg_318_1.var_.characterEffect1048ui_story and not isNil(var_321_6) then
					arg_318_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_7)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 and not isNil(var_321_6) and arg_318_1.var_.characterEffect1048ui_story then
				arg_318_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_321_8 = arg_318_1.actors_["1084ui_story"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1084ui_story = var_321_8.localPosition
			end

			local var_321_9 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_9 then
				var_321_8.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_318_1.time_ - 0) / var_321_9)
				var_321_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_8.position).x, (manager.ui.mainCamera.transform.position - var_321_8.position).y, (manager.ui.mainCamera.transform.position - var_321_8.position).z)
				var_321_8.localEulerAngles.z = 0
				var_321_8.localEulerAngles.x = 0
				var_321_8.localEulerAngles = var_321_8.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_9 and arg_318_1.time_ < 0 + var_321_9 + arg_321_0 then
				var_321_8.localPosition = Vector3.New(0, 100, 0)
				var_321_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_8.position).x, (manager.ui.mainCamera.transform.position - var_321_8.position).y, (manager.ui.mainCamera.transform.position - var_321_8.position).z)
				var_321_8.localEulerAngles.z = 0
				var_321_8.localEulerAngles.x = 0
				var_321_8.localEulerAngles = var_321_8.localEulerAngles
			end

			local var_321_10 = arg_318_1.actors_["1084ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_10) and arg_318_1.var_.characterEffect1084ui_story == nil then
				arg_318_1.var_.characterEffect1084ui_story = var_321_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_11 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_11 and not isNil(var_321_10) then
				if arg_318_1.var_.characterEffect1084ui_story and not isNil(var_321_10) then
					arg_318_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_11)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_11 and arg_318_1.time_ < 0 + var_321_11 + arg_321_0 and not isNil(var_321_10) and arg_318_1.var_.characterEffect1084ui_story then
				arg_318_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_321_12 = 0
			local var_321_13 = 1

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_12 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_14 = arg_318_1:GetWordFromCfg(910601081)
				local var_321_15 = arg_318_1:FormatText(var_321_14.content)

				arg_318_1.text_.text = var_321_15

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_17 = 40 <= 0 and var_321_13 or var_321_13 * (utf8.len(var_321_15) / 40)

				if (40 <= 0 and var_321_13 or var_321_13 * (utf8.len(var_321_15) / 40)) > 0 and var_321_13 < var_321_17 then
					arg_318_1.talkMaxDuration = var_321_17

					if var_321_17 + var_321_12 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_17 + var_321_12
					end
				end

				arg_318_1.text_.text = var_321_15
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601081", "story_v_out_910601.awb") ~= 0 then
					local var_321_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601081", "story_v_out_910601.awb") / 1000

					if var_321_18 + var_321_12 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_18 + var_321_12
					end

					if var_321_14.prefab_name ~= "" and arg_318_1.actors_[var_321_14.prefab_name] ~= nil then
						local var_321_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_14.prefab_name].transform, "story_v_out_910601", "910601081", "story_v_out_910601.awb")

						arg_318_1:RecordAudio("910601081", var_321_19)
						arg_318_1:RecordAudio("910601081", var_321_19)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_910601", "910601081", "story_v_out_910601.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_910601", "910601081", "story_v_out_910601.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_20 = math.max(var_321_13, arg_318_1.talkMaxDuration)

			if var_321_12 <= arg_318_1.time_ and arg_318_1.time_ < var_321_12 + var_321_20 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_12) / var_321_20

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_12 + var_321_20 and arg_318_1.time_ < var_321_12 + var_321_20 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play910601082 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 910601082
		arg_322_1.duration_ = 10.7

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play910601083(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1059ui_story = arg_322_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_325_0 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 then
				arg_322_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_322_1.time_ - 0) / var_325_0)
				arg_322_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1059ui_story"].transform.position).z)
				arg_322_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1059ui_story"].transform.localEulerAngles = arg_322_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 then
				arg_322_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6)
				arg_322_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1059ui_story"].transform.position).z)
				arg_322_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1059ui_story"].transform.localEulerAngles = arg_322_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_325_1 = arg_322_1.actors_["1059ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1059ui_story == nil then
				arg_322_1.var_.characterEffect1059ui_story = var_325_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_2 and not isNil(var_325_1) then
				if arg_322_1.var_.characterEffect1059ui_story and not isNil(var_325_1) then
					arg_322_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 0 + var_325_2 and arg_322_1.time_ < 0 + var_325_2 + arg_325_0 and not isNil(var_325_1) and arg_322_1.var_.characterEffect1059ui_story then
				arg_322_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_325_4 = arg_322_1.actors_["1011ui_story"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1011ui_story = var_325_4.localPosition
			end

			local var_325_5 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_5 then
				var_325_4.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_322_1.time_ - 0) / var_325_5)
				var_325_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_4.position).x, (manager.ui.mainCamera.transform.position - var_325_4.position).y, (manager.ui.mainCamera.transform.position - var_325_4.position).z)
				var_325_4.localEulerAngles.z = 0
				var_325_4.localEulerAngles.x = 0
				var_325_4.localEulerAngles = var_325_4.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_5 and arg_322_1.time_ < 0 + var_325_5 + arg_325_0 then
				var_325_4.localPosition = Vector3.New(0, 100, 0)
				var_325_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_4.position).x, (manager.ui.mainCamera.transform.position - var_325_4.position).y, (manager.ui.mainCamera.transform.position - var_325_4.position).z)
				var_325_4.localEulerAngles.z = 0
				var_325_4.localEulerAngles.x = 0
				var_325_4.localEulerAngles = var_325_4.localEulerAngles
			end

			local var_325_6 = arg_322_1.actors_["1011ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_6) and arg_322_1.var_.characterEffect1011ui_story == nil then
				arg_322_1.var_.characterEffect1011ui_story = var_325_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_7 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 and not isNil(var_325_6) then
				if arg_322_1.var_.characterEffect1011ui_story and not isNil(var_325_6) then
					arg_322_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_7)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 and not isNil(var_325_6) and arg_322_1.var_.characterEffect1011ui_story then
				arg_322_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_325_8 = 0
			local var_325_9 = 1.25

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_8 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_10 = arg_322_1:GetWordFromCfg(910601082)
				local var_325_11 = arg_322_1:FormatText(var_325_10.content)

				arg_322_1.text_.text = var_325_11

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_13 = 50 <= 0 and var_325_9 or var_325_9 * (utf8.len(var_325_11) / 50)

				if (50 <= 0 and var_325_9 or var_325_9 * (utf8.len(var_325_11) / 50)) > 0 and var_325_9 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_8 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_8
					end
				end

				arg_322_1.text_.text = var_325_11
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601082", "story_v_out_910601.awb") ~= 0 then
					local var_325_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601082", "story_v_out_910601.awb") / 1000

					if var_325_14 + var_325_8 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_14 + var_325_8
					end

					if var_325_10.prefab_name ~= "" and arg_322_1.actors_[var_325_10.prefab_name] ~= nil then
						local var_325_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_10.prefab_name].transform, "story_v_out_910601", "910601082", "story_v_out_910601.awb")

						arg_322_1:RecordAudio("910601082", var_325_15)
						arg_322_1:RecordAudio("910601082", var_325_15)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_910601", "910601082", "story_v_out_910601.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_910601", "910601082", "story_v_out_910601.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_16 = math.max(var_325_9, arg_322_1.talkMaxDuration)

			if var_325_8 <= arg_322_1.time_ and arg_322_1.time_ < var_325_8 + var_325_16 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_8) / var_325_16

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_8 + var_325_16 and arg_322_1.time_ < var_325_8 + var_325_16 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play910601083 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 910601083
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play910601084(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1059ui_story"]) and arg_326_1.var_.characterEffect1059ui_story == nil then
				arg_326_1.var_.characterEffect1059ui_story = arg_326_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1059ui_story"]) then
				if arg_326_1.var_.characterEffect1059ui_story and not isNil(arg_326_1.actors_["1059ui_story"]) then
					arg_326_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_0)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1059ui_story"]) and arg_326_1.var_.characterEffect1059ui_story then
				arg_326_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_329_1 = 0
			local var_329_2 = 0.35

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(910601083).content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 14 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 14)

				if (14 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 14)) > 0 and var_329_2 < var_329_5 then
					arg_326_1.talkMaxDuration = var_329_5

					if var_329_5 + var_329_1 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + var_329_1
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_6 = math.max(var_329_2, arg_326_1.talkMaxDuration)

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_6 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_1) / var_329_6

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_1 + var_329_6 and arg_326_1.time_ < var_329_1 + var_329_6 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play910601084 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 910601084
		arg_330_1.duration_ = 9.2

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play910601085(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1084ui_story = arg_330_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).z)
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles = arg_330_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_330_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1084ui_story"].transform.position).z)
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1084ui_story"].transform.localEulerAngles = arg_330_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["1084ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1084ui_story == nil then
				arg_330_1.var_.characterEffect1084ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect1084ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1084ui_story then
				arg_330_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_333_4 = arg_330_1.actors_["1059ui_story"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1059ui_story = var_333_4.localPosition
			end

			local var_333_5 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_5 then
				var_333_4.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_330_1.time_ - 0) / var_333_5)
				var_333_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_4.position).x, (manager.ui.mainCamera.transform.position - var_333_4.position).y, (manager.ui.mainCamera.transform.position - var_333_4.position).z)
				var_333_4.localEulerAngles.z = 0
				var_333_4.localEulerAngles.x = 0
				var_333_4.localEulerAngles = var_333_4.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_5 and arg_330_1.time_ < 0 + var_333_5 + arg_333_0 then
				var_333_4.localPosition = Vector3.New(0, 100, 0)
				var_333_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_333_4.position).x, (manager.ui.mainCamera.transform.position - var_333_4.position).y, (manager.ui.mainCamera.transform.position - var_333_4.position).z)
				var_333_4.localEulerAngles.z = 0
				var_333_4.localEulerAngles.x = 0
				var_333_4.localEulerAngles = var_333_4.localEulerAngles
			end

			local var_333_6 = arg_330_1.actors_["1059ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_6) and arg_330_1.var_.characterEffect1059ui_story == nil then
				arg_330_1.var_.characterEffect1059ui_story = var_333_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_7 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 and not isNil(var_333_6) then
				if arg_330_1.var_.characterEffect1059ui_story and not isNil(var_333_6) then
					arg_330_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_7)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 and not isNil(var_333_6) and arg_330_1.var_.characterEffect1059ui_story then
				arg_330_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_333_8 = 0
			local var_333_9 = 1.175

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_8 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_10 = arg_330_1:GetWordFromCfg(910601084)
				local var_333_11 = arg_330_1:FormatText(var_333_10.content)

				arg_330_1.text_.text = var_333_11

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_13 = 47 <= 0 and var_333_9 or var_333_9 * (utf8.len(var_333_11) / 47)

				if (47 <= 0 and var_333_9 or var_333_9 * (utf8.len(var_333_11) / 47)) > 0 and var_333_9 < var_333_13 then
					arg_330_1.talkMaxDuration = var_333_13

					if var_333_13 + var_333_8 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_13 + var_333_8
					end
				end

				arg_330_1.text_.text = var_333_11
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601084", "story_v_out_910601.awb") ~= 0 then
					local var_333_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601084", "story_v_out_910601.awb") / 1000

					if var_333_14 + var_333_8 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_14 + var_333_8
					end

					if var_333_10.prefab_name ~= "" and arg_330_1.actors_[var_333_10.prefab_name] ~= nil then
						local var_333_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_10.prefab_name].transform, "story_v_out_910601", "910601084", "story_v_out_910601.awb")

						arg_330_1:RecordAudio("910601084", var_333_15)
						arg_330_1:RecordAudio("910601084", var_333_15)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_910601", "910601084", "story_v_out_910601.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_910601", "910601084", "story_v_out_910601.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_16 = math.max(var_333_9, arg_330_1.talkMaxDuration)

			if var_333_8 <= arg_330_1.time_ and arg_330_1.time_ < var_333_8 + var_333_16 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_8) / var_333_16

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_8 + var_333_16 and arg_330_1.time_ < var_333_8 + var_333_16 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play910601085 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 910601085
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play910601086(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1084ui_story"]) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = arg_334_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1084ui_story"]) then
				if arg_334_1.var_.characterEffect1084ui_story and not isNil(arg_334_1.actors_["1084ui_story"]) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1084ui_story"]) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 0.675

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(910601085).content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 25 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 25)

				if (25 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 25)) > 0 and var_337_2 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_6 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_6 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_6

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_6 and arg_334_1.time_ < var_337_1 + var_337_6 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play910601086 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 910601086
		arg_338_1.duration_ = 2

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play910601087(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if arg_338_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_341_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_338_1.stage_.transform)

				var_341_0.name = "1184ui_story"
				var_341_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.actors_["1184ui_story"] = var_341_0

				local var_341_1 = var_341_0:GetComponentInChildren(typeof(CharacterEffect))

				var_341_1.enabled = true

				local var_341_2 = GameObjectTools.GetOrAddComponent(var_341_0, typeof(DynamicBoneHelper))

				if var_341_2 then
					var_341_2:EnableDynamicBone(false)
				end

				arg_338_1:ShowWeapon(var_341_1.transform, false)

				arg_338_1.var_["1184ui_story" .. "Animator"] = var_341_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_338_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_338_1.var_["1184ui_story" .. "LipSync"] = var_341_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_341_3 = arg_338_1.actors_["1184ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1184ui_story = var_341_3.localPosition
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_3.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_338_1.time_ - 0) / var_341_4)
				var_341_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_3.position).x, (manager.ui.mainCamera.transform.position - var_341_3.position).y, (manager.ui.mainCamera.transform.position - var_341_3.position).z)
				var_341_3.localEulerAngles.z = 0
				var_341_3.localEulerAngles.x = 0
				var_341_3.localEulerAngles = var_341_3.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_3.localPosition = Vector3.New(0, -0.97, -6)
				var_341_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_3.position).x, (manager.ui.mainCamera.transform.position - var_341_3.position).y, (manager.ui.mainCamera.transform.position - var_341_3.position).z)
				var_341_3.localEulerAngles.z = 0
				var_341_3.localEulerAngles.x = 0
				var_341_3.localEulerAngles = var_341_3.localEulerAngles
			end

			local var_341_5 = arg_338_1.actors_["1084ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_5) and arg_338_1.var_.characterEffect1084ui_story == nil then
				arg_338_1.var_.characterEffect1084ui_story = var_341_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_6 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_6 and not isNil(var_341_5) then
				if arg_338_1.var_.characterEffect1084ui_story and not isNil(var_341_5) then
					arg_338_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_6 and arg_338_1.time_ < 0 + var_341_6 + arg_341_0 and not isNil(var_341_5) and arg_338_1.var_.characterEffect1084ui_story then
				arg_338_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4212")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_341_8 = arg_338_1.actors_["1084ui_story"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1084ui_story = var_341_8.localPosition
			end

			local var_341_9 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_9 then
				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 0) / var_341_9)
				var_341_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_8.position).x, (manager.ui.mainCamera.transform.position - var_341_8.position).y, (manager.ui.mainCamera.transform.position - var_341_8.position).z)
				var_341_8.localEulerAngles.z = 0
				var_341_8.localEulerAngles.x = 0
				var_341_8.localEulerAngles = var_341_8.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_9 and arg_338_1.time_ < 0 + var_341_9 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, 100, 0)
				var_341_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_341_8.position).x, (manager.ui.mainCamera.transform.position - var_341_8.position).y, (manager.ui.mainCamera.transform.position - var_341_8.position).z)
				var_341_8.localEulerAngles.z = 0
				var_341_8.localEulerAngles.x = 0
				var_341_8.localEulerAngles = var_341_8.localEulerAngles
			end

			local var_341_10 = 0
			local var_341_11 = 0.1

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_10 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_12 = arg_338_1:GetWordFromCfg(910601086)
				local var_341_13 = arg_338_1:FormatText(var_341_12.content)

				arg_338_1.text_.text = var_341_13

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_15 = 4 <= 0 and var_341_11 or var_341_11 * (utf8.len(var_341_13) / 4)

				if (4 <= 0 and var_341_11 or var_341_11 * (utf8.len(var_341_13) / 4)) > 0 and var_341_11 < var_341_15 then
					arg_338_1.talkMaxDuration = var_341_15

					if var_341_15 + var_341_10 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_15 + var_341_10
					end
				end

				arg_338_1.text_.text = var_341_13
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601086", "story_v_out_910601.awb") ~= 0 then
					local var_341_16 = manager.audio:GetVoiceLength("story_v_out_910601", "910601086", "story_v_out_910601.awb") / 1000

					if var_341_16 + var_341_10 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_16 + var_341_10
					end

					if var_341_12.prefab_name ~= "" and arg_338_1.actors_[var_341_12.prefab_name] ~= nil then
						local var_341_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_12.prefab_name].transform, "story_v_out_910601", "910601086", "story_v_out_910601.awb")

						arg_338_1:RecordAudio("910601086", var_341_17)
						arg_338_1:RecordAudio("910601086", var_341_17)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_910601", "910601086", "story_v_out_910601.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_910601", "910601086", "story_v_out_910601.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_18 = math.max(var_341_11, arg_338_1.talkMaxDuration)

			if var_341_10 <= arg_338_1.time_ and arg_338_1.time_ < var_341_10 + var_341_18 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_10) / var_341_18

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_10 + var_341_18 and arg_338_1.time_ < var_341_10 + var_341_18 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play910601087 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 910601087
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play910601088(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1184ui_story"]) and arg_342_1.var_.characterEffect1184ui_story == nil then
				arg_342_1.var_.characterEffect1184ui_story = arg_342_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1184ui_story"]) then
				if arg_342_1.var_.characterEffect1184ui_story and not isNil(arg_342_1.actors_["1184ui_story"]) then
					arg_342_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1184ui_story"]) and arg_342_1.var_.characterEffect1184ui_story then
				arg_342_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_345_1 = arg_342_1.actors_["1184ui_story"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1184ui_story = var_345_1.localPosition
			end

			local var_345_2 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_2 then
				var_345_1.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_342_1.time_ - 0) / var_345_2)
				var_345_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_1.position).x, (manager.ui.mainCamera.transform.position - var_345_1.position).y, (manager.ui.mainCamera.transform.position - var_345_1.position).z)
				var_345_1.localEulerAngles.z = 0
				var_345_1.localEulerAngles.x = 0
				var_345_1.localEulerAngles = var_345_1.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_2 and arg_342_1.time_ < 0 + var_345_2 + arg_345_0 then
				var_345_1.localPosition = Vector3.New(0, 100, 0)
				var_345_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_1.position).x, (manager.ui.mainCamera.transform.position - var_345_1.position).y, (manager.ui.mainCamera.transform.position - var_345_1.position).z)
				var_345_1.localEulerAngles.z = 0
				var_345_1.localEulerAngles.x = 0
				var_345_1.localEulerAngles = var_345_1.localEulerAngles
			end

			local var_345_3 = 0
			local var_345_4 = 0.375

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_5 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(910601087).content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 15 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_5) / 15)

				if (15 <= 0 and var_345_4 or var_345_4 * (utf8.len(var_345_5) / 15)) > 0 and var_345_4 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_3 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_3
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_4, arg_342_1.talkMaxDuration)

			if var_345_3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_3 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_3) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_3 + var_345_8 and arg_342_1.time_ < var_345_3 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play910601088 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 910601088
		arg_346_1.duration_ = 2.9

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play910601089(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1084ui_story = arg_346_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1084ui_story"].transform.position).z)
				arg_346_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1084ui_story"].transform.localEulerAngles = arg_346_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_346_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1084ui_story"].transform.position).z)
				arg_346_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1084ui_story"].transform.localEulerAngles = arg_346_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["1084ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1084ui_story == nil then
				arg_346_1.var_.characterEffect1084ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect1084ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1084ui_story then
				arg_346_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_349_4 = 0
			local var_349_5 = 0.375

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_6 = arg_346_1:GetWordFromCfg(910601088)
				local var_349_7 = arg_346_1:FormatText(var_349_6.content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 15 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 15)

				if (15 <= 0 and var_349_5 or var_349_5 * (utf8.len(var_349_7) / 15)) > 0 and var_349_5 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_4
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601088", "story_v_out_910601.awb") ~= 0 then
					local var_349_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601088", "story_v_out_910601.awb") / 1000

					if var_349_10 + var_349_4 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_4
					end

					if var_349_6.prefab_name ~= "" and arg_346_1.actors_[var_349_6.prefab_name] ~= nil then
						local var_349_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_6.prefab_name].transform, "story_v_out_910601", "910601088", "story_v_out_910601.awb")

						arg_346_1:RecordAudio("910601088", var_349_11)
						arg_346_1:RecordAudio("910601088", var_349_11)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_910601", "910601088", "story_v_out_910601.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_910601", "910601088", "story_v_out_910601.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_12 = math.max(var_349_5, arg_346_1.talkMaxDuration)

			if var_349_4 <= arg_346_1.time_ and arg_346_1.time_ < var_349_4 + var_349_12 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_4) / var_349_12

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_4 + var_349_12 and arg_346_1.time_ < var_349_4 + var_349_12 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play910601089 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 910601089
		arg_350_1.duration_ = 13.17

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play910601090(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1084ui_story = arg_350_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).z)
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles = arg_350_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_350_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1084ui_story"].transform.position).z)
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1084ui_story"].transform.localEulerAngles = arg_350_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_353_1 = arg_350_1.actors_["1084ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect1084ui_story == nil then
				arg_350_1.var_.characterEffect1084ui_story = var_353_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 and not isNil(var_353_1) then
				if arg_350_1.var_.characterEffect1084ui_story and not isNil(var_353_1) then
					arg_350_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect1084ui_story then
				arg_350_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_353_4 = 0
			local var_353_5 = 1.3

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:GetWordFromCfg(910601089)
				local var_353_7 = arg_350_1:FormatText(var_353_6.content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 52 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 52)

				if (52 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 52)) > 0 and var_353_5 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601089", "story_v_out_910601.awb") ~= 0 then
					local var_353_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601089", "story_v_out_910601.awb") / 1000

					if var_353_10 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_4
					end

					if var_353_6.prefab_name ~= "" and arg_350_1.actors_[var_353_6.prefab_name] ~= nil then
						local var_353_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_6.prefab_name].transform, "story_v_out_910601", "910601089", "story_v_out_910601.awb")

						arg_350_1:RecordAudio("910601089", var_353_11)
						arg_350_1:RecordAudio("910601089", var_353_11)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_910601", "910601089", "story_v_out_910601.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_910601", "910601089", "story_v_out_910601.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_12 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_12 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_12

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_12 and arg_350_1.time_ < var_353_4 + var_353_12 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play910601090 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 910601090
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play910601091(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1084ui_story"]) and arg_354_1.var_.characterEffect1084ui_story == nil then
				arg_354_1.var_.characterEffect1084ui_story = arg_354_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1084ui_story"]) then
				if arg_354_1.var_.characterEffect1084ui_story and not isNil(arg_354_1.actors_["1084ui_story"]) then
					arg_354_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_354_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_0)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1084ui_story"]) and arg_354_1.var_.characterEffect1084ui_story then
				arg_354_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_354_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_357_1 = 0
			local var_357_2 = 0.425

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(910601090).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 17 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 17)

				if (17 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 17)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play910601091 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 910601091
		arg_358_1.duration_ = 6.83

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play910601092(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1084ui_story"]) and arg_358_1.var_.characterEffect1084ui_story == nil then
				arg_358_1.var_.characterEffect1084ui_story = arg_358_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1084ui_story"]) then
				if arg_358_1.var_.characterEffect1084ui_story and not isNil(arg_358_1.actors_["1084ui_story"]) then
					arg_358_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1084ui_story"]) and arg_358_1.var_.characterEffect1084ui_story then
				arg_358_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_361_2 = 0
			local var_361_3 = 0.65

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_2 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_4 = arg_358_1:GetWordFromCfg(910601091)
				local var_361_5 = arg_358_1:FormatText(var_361_4.content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 26 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 26)

				if (26 <= 0 and var_361_3 or var_361_3 * (utf8.len(var_361_5) / 26)) > 0 and var_361_3 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_2
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601091", "story_v_out_910601.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601091", "story_v_out_910601.awb") / 1000

					if var_361_8 + var_361_2 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_2
					end

					if var_361_4.prefab_name ~= "" and arg_358_1.actors_[var_361_4.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_4.prefab_name].transform, "story_v_out_910601", "910601091", "story_v_out_910601.awb")

						arg_358_1:RecordAudio("910601091", var_361_9)
						arg_358_1:RecordAudio("910601091", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_910601", "910601091", "story_v_out_910601.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_910601", "910601091", "story_v_out_910601.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_3, arg_358_1.talkMaxDuration)

			if var_361_2 <= arg_358_1.time_ and arg_358_1.time_ < var_361_2 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_2) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_2 + var_361_10 and arg_358_1.time_ < var_361_2 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play910601092 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 910601092
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play910601093(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1084ui_story"]) and arg_362_1.var_.characterEffect1084ui_story == nil then
				arg_362_1.var_.characterEffect1084ui_story = arg_362_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1084ui_story"]) then
				if arg_362_1.var_.characterEffect1084ui_story and not isNil(arg_362_1.actors_["1084ui_story"]) then
					arg_362_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 0) / var_365_0)
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1084ui_story"]) and arg_362_1.var_.characterEffect1084ui_story then
				arg_362_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_365_1 = 0
			local var_365_2 = 0.5

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(910601092).content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 20 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 20)

				if (20 <= 0 and var_365_2 or var_365_2 * (utf8.len(var_365_3) / 20)) > 0 and var_365_2 < var_365_5 then
					arg_362_1.talkMaxDuration = var_365_5

					if var_365_5 + var_365_1 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + var_365_1
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_6 = math.max(var_365_2, arg_362_1.talkMaxDuration)

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_6 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_1) / var_365_6

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_1 + var_365_6 and arg_362_1.time_ < var_365_1 + var_365_6 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play910601093 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 910601093
		arg_366_1.duration_ = 4.63

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play910601094(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1084ui_story"]) and arg_366_1.var_.characterEffect1084ui_story == nil then
				arg_366_1.var_.characterEffect1084ui_story = arg_366_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1084ui_story"]) then
				if arg_366_1.var_.characterEffect1084ui_story and not isNil(arg_366_1.actors_["1084ui_story"]) then
					arg_366_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1084ui_story"]) and arg_366_1.var_.characterEffect1084ui_story then
				arg_366_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action475")
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_369_2 = 0
			local var_369_3 = 0.45

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_2 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_4 = arg_366_1:GetWordFromCfg(910601093)
				local var_369_5 = arg_366_1:FormatText(var_369_4.content)

				arg_366_1.text_.text = var_369_5

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_7 = 18 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 18)

				if (18 <= 0 and var_369_3 or var_369_3 * (utf8.len(var_369_5) / 18)) > 0 and var_369_3 < var_369_7 then
					arg_366_1.talkMaxDuration = var_369_7

					if var_369_7 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_7 + var_369_2
					end
				end

				arg_366_1.text_.text = var_369_5
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601093", "story_v_out_910601.awb") ~= 0 then
					local var_369_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601093", "story_v_out_910601.awb") / 1000

					if var_369_8 + var_369_2 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_8 + var_369_2
					end

					if var_369_4.prefab_name ~= "" and arg_366_1.actors_[var_369_4.prefab_name] ~= nil then
						local var_369_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_4.prefab_name].transform, "story_v_out_910601", "910601093", "story_v_out_910601.awb")

						arg_366_1:RecordAudio("910601093", var_369_9)
						arg_366_1:RecordAudio("910601093", var_369_9)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_910601", "910601093", "story_v_out_910601.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_910601", "910601093", "story_v_out_910601.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_10 = math.max(var_369_3, arg_366_1.talkMaxDuration)

			if var_369_2 <= arg_366_1.time_ and arg_366_1.time_ < var_369_2 + var_369_10 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_2) / var_369_10

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_2 + var_369_10 and arg_366_1.time_ < var_369_2 + var_369_10 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play910601094 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 910601094
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play910601095(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) and arg_370_1.var_.characterEffect1084ui_story == nil then
				arg_370_1.var_.characterEffect1084ui_story = arg_370_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) then
				if arg_370_1.var_.characterEffect1084ui_story and not isNil(arg_370_1.actors_["1084ui_story"]) then
					arg_370_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_370_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_0)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1084ui_story"]) and arg_370_1.var_.characterEffect1084ui_story then
				arg_370_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_370_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_373_1 = 0
			local var_373_2 = 0.625

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(910601094).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 25 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 25)

				if (25 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 25)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play910601095 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 910601095
		arg_374_1.duration_ = 3.83

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play910601096(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1011ui_story = arg_374_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_377_0 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 then
				arg_374_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_374_1.time_ - 0) / var_377_0)
				arg_374_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1011ui_story"].transform.position).z)
				arg_374_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1011ui_story"].transform.localEulerAngles = arg_374_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 then
				arg_374_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_374_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1011ui_story"].transform.position).z)
				arg_374_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1011ui_story"].transform.localEulerAngles = arg_374_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_377_1 = arg_374_1.actors_["1011ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1011ui_story == nil then
				arg_374_1.var_.characterEffect1011ui_story = var_377_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_2 and not isNil(var_377_1) then
				if arg_374_1.var_.characterEffect1011ui_story and not isNil(var_377_1) then
					arg_374_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_2 and arg_374_1.time_ < 0 + var_377_2 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1011ui_story then
				arg_374_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_377_4 = arg_374_1.actors_["1084ui_story"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1084ui_story = var_377_4.localPosition
			end

			local var_377_5 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_5 then
				var_377_4.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_374_1.time_ - 0) / var_377_5)
				var_377_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_377_4.position).x, (manager.ui.mainCamera.transform.position - var_377_4.position).y, (manager.ui.mainCamera.transform.position - var_377_4.position).z)
				var_377_4.localEulerAngles.z = 0
				var_377_4.localEulerAngles.x = 0
				var_377_4.localEulerAngles = var_377_4.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_5 and arg_374_1.time_ < 0 + var_377_5 + arg_377_0 then
				var_377_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_377_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_377_4.position).x, (manager.ui.mainCamera.transform.position - var_377_4.position).y, (manager.ui.mainCamera.transform.position - var_377_4.position).z)
				var_377_4.localEulerAngles.z = 0
				var_377_4.localEulerAngles.x = 0
				var_377_4.localEulerAngles = var_377_4.localEulerAngles
			end

			local var_377_6 = arg_374_1.actors_["1084ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_6) and arg_374_1.var_.characterEffect1084ui_story == nil then
				arg_374_1.var_.characterEffect1084ui_story = var_377_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_7 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 and not isNil(var_377_6) then
				if arg_374_1.var_.characterEffect1084ui_story and not isNil(var_377_6) then
					arg_374_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_7)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 and not isNil(var_377_6) and arg_374_1.var_.characterEffect1084ui_story then
				arg_374_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_377_8 = 0
			local var_377_9 = 0.425

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_8 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_10 = arg_374_1:GetWordFromCfg(910601095)
				local var_377_11 = arg_374_1:FormatText(var_377_10.content)

				arg_374_1.text_.text = var_377_11

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_13 = 17 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 17)

				if (17 <= 0 and var_377_9 or var_377_9 * (utf8.len(var_377_11) / 17)) > 0 and var_377_9 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_8
					end
				end

				arg_374_1.text_.text = var_377_11
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601095", "story_v_out_910601.awb") ~= 0 then
					local var_377_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601095", "story_v_out_910601.awb") / 1000

					if var_377_14 + var_377_8 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_8
					end

					if var_377_10.prefab_name ~= "" and arg_374_1.actors_[var_377_10.prefab_name] ~= nil then
						local var_377_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_10.prefab_name].transform, "story_v_out_910601", "910601095", "story_v_out_910601.awb")

						arg_374_1:RecordAudio("910601095", var_377_15)
						arg_374_1:RecordAudio("910601095", var_377_15)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_910601", "910601095", "story_v_out_910601.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_910601", "910601095", "story_v_out_910601.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_9, arg_374_1.talkMaxDuration)

			if var_377_8 <= arg_374_1.time_ and arg_374_1.time_ < var_377_8 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_8) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_8 + var_377_16 and arg_374_1.time_ < var_377_8 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play910601096 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 910601096
		arg_378_1.duration_ = 4.3

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play910601097(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1084ui_story = arg_378_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).z)
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles = arg_378_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_378_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1084ui_story"].transform.position).z)
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1084ui_story"].transform.localEulerAngles = arg_378_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_381_1 = arg_378_1.actors_["1084ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1084ui_story == nil then
				arg_378_1.var_.characterEffect1084ui_story = var_381_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_2 and not isNil(var_381_1) then
				if arg_378_1.var_.characterEffect1084ui_story and not isNil(var_381_1) then
					arg_378_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_2 and arg_378_1.time_ < 0 + var_381_2 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1084ui_story then
				arg_378_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_381_4 = arg_378_1.actors_["1011ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_4) and arg_378_1.var_.characterEffect1011ui_story == nil then
				arg_378_1.var_.characterEffect1011ui_story = var_381_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_5 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_5 and not isNil(var_381_4) then
				if arg_378_1.var_.characterEffect1011ui_story and not isNil(var_381_4) then
					arg_378_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_5)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_5 and arg_378_1.time_ < 0 + var_381_5 + arg_381_0 and not isNil(var_381_4) and arg_378_1.var_.characterEffect1011ui_story then
				arg_378_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_381_6 = 0
			local var_381_7 = 0.475

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_6 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_8 = arg_378_1:GetWordFromCfg(910601096)
				local var_381_9 = arg_378_1:FormatText(var_381_8.content)

				arg_378_1.text_.text = var_381_9

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_11 = 19 <= 0 and var_381_7 or var_381_7 * (utf8.len(var_381_9) / 19)

				if (19 <= 0 and var_381_7 or var_381_7 * (utf8.len(var_381_9) / 19)) > 0 and var_381_7 < var_381_11 then
					arg_378_1.talkMaxDuration = var_381_11

					if var_381_11 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_11 + var_381_6
					end
				end

				arg_378_1.text_.text = var_381_9
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601096", "story_v_out_910601.awb") ~= 0 then
					local var_381_12 = manager.audio:GetVoiceLength("story_v_out_910601", "910601096", "story_v_out_910601.awb") / 1000

					if var_381_12 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_12 + var_381_6
					end

					if var_381_8.prefab_name ~= "" and arg_378_1.actors_[var_381_8.prefab_name] ~= nil then
						local var_381_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_8.prefab_name].transform, "story_v_out_910601", "910601096", "story_v_out_910601.awb")

						arg_378_1:RecordAudio("910601096", var_381_13)
						arg_378_1:RecordAudio("910601096", var_381_13)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_910601", "910601096", "story_v_out_910601.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_910601", "910601096", "story_v_out_910601.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_7, arg_378_1.talkMaxDuration)

			if var_381_6 <= arg_378_1.time_ and arg_378_1.time_ < var_381_6 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_6) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_6 + var_381_14 and arg_378_1.time_ < var_381_6 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play910601097 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 910601097
		arg_382_1.duration_ = 9

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play910601098(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 then
				local var_385_0 = arg_382_1.bgs_.STwhite

				arg_382_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_385_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_385_1 = var_385_0:GetComponent("SpriteRenderer")

				if var_385_1 and var_385_1.sprite then
					local var_385_2 = 2 * (var_385_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_385_0.transform.localScale = Vector3.New(var_385_2 / var_385_1.sprite.bounds.size.y < var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x and var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x or var_385_2 / var_385_1.sprite.bounds.size.y, var_385_2 / var_385_1.sprite.bounds.size.y < var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x and var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x or var_385_2 / var_385_1.sprite.bounds.size.y, 0)
				end

				for iter_385_0, iter_385_1 in pairs(arg_382_1.bgs_) do
					if iter_385_0 ~= "STwhite" then
						iter_385_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_385_3 = 0

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_3 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_4 = 2

			if var_385_3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_3 + var_385_4 then
				local var_385_5 = Color.New(0, 0, 0)

				var_385_5.a = Mathf.Lerp(0, 1, (arg_382_1.time_ - var_385_3) / var_385_4)
				arg_382_1.mask_.color = var_385_5
			end

			if arg_382_1.time_ >= var_385_3 + var_385_4 and arg_382_1.time_ < var_385_3 + var_385_4 + arg_385_0 then
				local var_385_6 = Color.New(0, 0, 0)

				var_385_6.a = 1
				arg_382_1.mask_.color = var_385_6
			end

			local var_385_7 = 2

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= var_385_7 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_8 = 2

			if var_385_7 <= arg_382_1.time_ and arg_382_1.time_ < var_385_7 + var_385_8 then
				local var_385_9 = Color.New(0, 0, 0)

				var_385_9.a = Mathf.Lerp(1, 0, (arg_382_1.time_ - var_385_7) / var_385_8)
				arg_382_1.mask_.color = var_385_9
			end

			if arg_382_1.time_ >= var_385_7 + var_385_8 and arg_382_1.time_ < var_385_7 + var_385_8 + arg_385_0 then
				local var_385_10 = Color.New(0, 0, 0)

				arg_382_1.mask_.enabled = false
				var_385_10.a = 0
				arg_382_1.mask_.color = var_385_10
			end

			local var_385_11 = arg_382_1.actors_["1011ui_story"].transform

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 then
				arg_382_1.var_.moveOldPos1011ui_story = var_385_11.localPosition
			end

			local var_385_12 = 0.001

			if 2 <= arg_382_1.time_ and arg_382_1.time_ < 2 + var_385_12 then
				var_385_11.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_382_1.time_ - 2) / var_385_12)
				var_385_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_11.position).x, (manager.ui.mainCamera.transform.position - var_385_11.position).y, (manager.ui.mainCamera.transform.position - var_385_11.position).z)
				var_385_11.localEulerAngles.z = 0
				var_385_11.localEulerAngles.x = 0
				var_385_11.localEulerAngles = var_385_11.localEulerAngles
			end

			if arg_382_1.time_ >= 2 + var_385_12 and arg_382_1.time_ < 2 + var_385_12 + arg_385_0 then
				var_385_11.localPosition = Vector3.New(0, 100, 0)
				var_385_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_11.position).x, (manager.ui.mainCamera.transform.position - var_385_11.position).y, (manager.ui.mainCamera.transform.position - var_385_11.position).z)
				var_385_11.localEulerAngles.z = 0
				var_385_11.localEulerAngles.x = 0
				var_385_11.localEulerAngles = var_385_11.localEulerAngles
			end

			local var_385_13 = arg_382_1.actors_["1011ui_story"]

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 and not isNil(var_385_13) and arg_382_1.var_.characterEffect1011ui_story == nil then
				arg_382_1.var_.characterEffect1011ui_story = var_385_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_14 = 0.200000002980232

			if 2 <= arg_382_1.time_ and arg_382_1.time_ < 2 + var_385_14 and not isNil(var_385_13) then
				if arg_382_1.var_.characterEffect1011ui_story and not isNil(var_385_13) then
					arg_382_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 2) / var_385_14)
				end
			end

			if arg_382_1.time_ >= 2 + var_385_14 and arg_382_1.time_ < 2 + var_385_14 + arg_385_0 and not isNil(var_385_13) and arg_382_1.var_.characterEffect1011ui_story then
				arg_382_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_385_15 = arg_382_1.actors_["1084ui_story"].transform

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 then
				arg_382_1.var_.moveOldPos1084ui_story = var_385_15.localPosition
			end

			local var_385_16 = 0.001

			if 2 <= arg_382_1.time_ and arg_382_1.time_ < 2 + var_385_16 then
				var_385_15.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_382_1.time_ - 2) / var_385_16)
				var_385_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_15.position).x, (manager.ui.mainCamera.transform.position - var_385_15.position).y, (manager.ui.mainCamera.transform.position - var_385_15.position).z)
				var_385_15.localEulerAngles.z = 0
				var_385_15.localEulerAngles.x = 0
				var_385_15.localEulerAngles = var_385_15.localEulerAngles
			end

			if arg_382_1.time_ >= 2 + var_385_16 and arg_382_1.time_ < 2 + var_385_16 + arg_385_0 then
				var_385_15.localPosition = Vector3.New(0, 100, 0)
				var_385_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_385_15.position).x, (manager.ui.mainCamera.transform.position - var_385_15.position).y, (manager.ui.mainCamera.transform.position - var_385_15.position).z)
				var_385_15.localEulerAngles.z = 0
				var_385_15.localEulerAngles.x = 0
				var_385_15.localEulerAngles = var_385_15.localEulerAngles
			end

			local var_385_17 = arg_382_1.actors_["1084ui_story"]

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 and not isNil(var_385_17) and arg_382_1.var_.characterEffect1084ui_story == nil then
				arg_382_1.var_.characterEffect1084ui_story = var_385_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_18 = 0.200000002980232

			if 2 <= arg_382_1.time_ and arg_382_1.time_ < 2 + var_385_18 and not isNil(var_385_17) then
				if arg_382_1.var_.characterEffect1084ui_story and not isNil(var_385_17) then
					arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 2) / var_385_18)
				end
			end

			if arg_382_1.time_ >= 2 + var_385_18 and arg_382_1.time_ < 2 + var_385_18 + arg_385_0 and not isNil(var_385_17) and arg_382_1.var_.characterEffect1084ui_story then
				arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_19 = 4
			local var_385_20 = 0.05

			if 4 < arg_382_1.time_ and arg_382_1.time_ <= var_385_19 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_21 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_21:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_382_1.dialogCg_.alpha = arg_386_0
				end))
				var_385_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_22 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(910601097).content)

				arg_382_1.text_.text = var_385_22

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_24 = 2 <= 0 and var_385_20 or var_385_20 * (utf8.len(var_385_22) / 2)

				if (2 <= 0 and var_385_20 or var_385_20 * (utf8.len(var_385_22) / 2)) > 0 and var_385_20 < var_385_24 then
					arg_382_1.talkMaxDuration = var_385_24
					var_385_19 = var_385_19 + 0.3

					if var_385_24 + var_385_19 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_24 + var_385_19
					end
				end

				arg_382_1.text_.text = var_385_22
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_25 = var_385_19 + 0.3
			local var_385_26 = math.max(var_385_20, arg_382_1.talkMaxDuration)

			if var_385_19 + 0.3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_25 + var_385_26 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_25) / var_385_26

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_25 + var_385_26 and arg_382_1.time_ < var_385_25 + var_385_26 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play910601098 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 910601098
		arg_388_1.duration_ = 9

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play910601099(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if arg_388_1.bgs_.ST60 == nil then
				local var_391_0 = Object.Instantiate(arg_388_1.paintGo_)

				var_391_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")
				var_391_0.name = "ST60"
				var_391_0.transform.parent = arg_388_1.stage_.transform
				var_391_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_388_1.bgs_.ST60 = var_391_0
			end

			if 2 < arg_388_1.time_ and arg_388_1.time_ <= 2 + arg_391_0 then
				local var_391_1 = arg_388_1.bgs_.ST60

				arg_388_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_391_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_2 = var_391_1:GetComponent("SpriteRenderer")

				if var_391_2 and var_391_2.sprite then
					local var_391_3 = 2 * (var_391_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_391_1.transform.localScale = Vector3.New(var_391_3 / var_391_2.sprite.bounds.size.y < var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x and var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x or var_391_3 / var_391_2.sprite.bounds.size.y, var_391_3 / var_391_2.sprite.bounds.size.y < var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x and var_391_3 * manager.ui.mainCameraCom_.aspect / var_391_2.sprite.bounds.size.x or var_391_3 / var_391_2.sprite.bounds.size.y, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "ST60" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_4 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_5 = 2

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_5 then
				local var_391_6 = Color.New(0, 0, 0)

				var_391_6.a = Mathf.Lerp(0, 1, (arg_388_1.time_ - var_391_4) / var_391_5)
				arg_388_1.mask_.color = var_391_6
			end

			if arg_388_1.time_ >= var_391_4 + var_391_5 and arg_388_1.time_ < var_391_4 + var_391_5 + arg_391_0 then
				local var_391_7 = Color.New(0, 0, 0)

				var_391_7.a = 1
				arg_388_1.mask_.color = var_391_7
			end

			local var_391_8 = 2

			if 2 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_9 = 2

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_9 then
				local var_391_10 = Color.New(0, 0, 0)

				var_391_10.a = Mathf.Lerp(1, 0, (arg_388_1.time_ - var_391_8) / var_391_9)
				arg_388_1.mask_.color = var_391_10
			end

			if arg_388_1.time_ >= var_391_8 + var_391_9 and arg_388_1.time_ < var_391_8 + var_391_9 + arg_391_0 then
				local var_391_11 = Color.New(0, 0, 0)

				arg_388_1.mask_.enabled = false
				var_391_11.a = 0
				arg_388_1.mask_.color = var_391_11
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_12 = 4
			local var_391_13 = 1.225

			if 4 < arg_388_1.time_ and arg_388_1.time_ <= var_391_12 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_14 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_14:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_15 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(910601098).content)

				arg_388_1.text_.text = var_391_15

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_17 = 49 <= 0 and var_391_13 or var_391_13 * (utf8.len(var_391_15) / 49)

				if (49 <= 0 and var_391_13 or var_391_13 * (utf8.len(var_391_15) / 49)) > 0 and var_391_13 < var_391_17 then
					arg_388_1.talkMaxDuration = var_391_17
					var_391_12 = var_391_12 + 0.3

					if var_391_17 + var_391_12 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_17 + var_391_12
					end
				end

				arg_388_1.text_.text = var_391_15
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_18 = var_391_12 + 0.3
			local var_391_19 = math.max(var_391_13, arg_388_1.talkMaxDuration)

			if var_391_12 + 0.3 <= arg_388_1.time_ and arg_388_1.time_ < var_391_18 + var_391_19 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_18) / var_391_19

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_18 + var_391_19 and arg_388_1.time_ < var_391_18 + var_391_19 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play910601099 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 910601099
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play910601100(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.5

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(910601099).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 20 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 20)

				if (20 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 20)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play910601100 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 910601100
		arg_398_1.duration_ = 2

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play910601101(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_401_0 = arg_398_1.actors_["1084ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1084ui_story == nil then
				arg_398_1.var_.characterEffect1084ui_story = var_401_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_1 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_1 and not isNil(var_401_0) then
				if arg_398_1.var_.characterEffect1084ui_story and not isNil(var_401_0) then
					arg_398_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_1 and arg_398_1.time_ < 0 + var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1084ui_story then
				arg_398_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_401_3 = arg_398_1.actors_["1084ui_story"].transform

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1084ui_story = var_401_3.localPosition
			end

			local var_401_4 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				var_401_3.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_398_1.time_ - 0) / var_401_4)
				var_401_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_401_3.position).x, (manager.ui.mainCamera.transform.position - var_401_3.position).y, (manager.ui.mainCamera.transform.position - var_401_3.position).z)
				var_401_3.localEulerAngles.z = 0
				var_401_3.localEulerAngles.x = 0
				var_401_3.localEulerAngles = var_401_3.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				var_401_3.localPosition = Vector3.New(0, -0.97, -6)
				var_401_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_401_3.position).x, (manager.ui.mainCamera.transform.position - var_401_3.position).y, (manager.ui.mainCamera.transform.position - var_401_3.position).z)
				var_401_3.localEulerAngles.z = 0
				var_401_3.localEulerAngles.x = 0
				var_401_3.localEulerAngles = var_401_3.localEulerAngles
			end

			local var_401_5 = 0
			local var_401_6 = 0.2

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_5 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_7 = arg_398_1:GetWordFromCfg(910601100)
				local var_401_8 = arg_398_1:FormatText(var_401_7.content)

				arg_398_1.text_.text = var_401_8

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_10 = 8 <= 0 and var_401_6 or var_401_6 * (utf8.len(var_401_8) / 8)

				if (8 <= 0 and var_401_6 or var_401_6 * (utf8.len(var_401_8) / 8)) > 0 and var_401_6 < var_401_10 then
					arg_398_1.talkMaxDuration = var_401_10

					if var_401_10 + var_401_5 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_5
					end
				end

				arg_398_1.text_.text = var_401_8
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601100", "story_v_out_910601.awb") ~= 0 then
					local var_401_11 = manager.audio:GetVoiceLength("story_v_out_910601", "910601100", "story_v_out_910601.awb") / 1000

					if var_401_11 + var_401_5 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_11 + var_401_5
					end

					if var_401_7.prefab_name ~= "" and arg_398_1.actors_[var_401_7.prefab_name] ~= nil then
						local var_401_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_7.prefab_name].transform, "story_v_out_910601", "910601100", "story_v_out_910601.awb")

						arg_398_1:RecordAudio("910601100", var_401_12)
						arg_398_1:RecordAudio("910601100", var_401_12)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_910601", "910601100", "story_v_out_910601.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_910601", "910601100", "story_v_out_910601.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_13 = math.max(var_401_6, arg_398_1.talkMaxDuration)

			if var_401_5 <= arg_398_1.time_ and arg_398_1.time_ < var_401_5 + var_401_13 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_5) / var_401_13

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_5 + var_401_13 and arg_398_1.time_ < var_401_5 + var_401_13 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play910601101 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 910601101
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play910601102(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["1084ui_story"]) and arg_402_1.var_.characterEffect1084ui_story == nil then
				arg_402_1.var_.characterEffect1084ui_story = arg_402_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["1084ui_story"]) then
				if arg_402_1.var_.characterEffect1084ui_story and not isNil(arg_402_1.actors_["1084ui_story"]) then
					arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["1084ui_story"]) and arg_402_1.var_.characterEffect1084ui_story then
				arg_402_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_405_1 = 0
			local var_405_2 = 0.575

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(910601101).content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 23 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 23)

				if (23 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 23)) > 0 and var_405_2 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_6 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_6 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_6

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_6 and arg_402_1.time_ < var_405_1 + var_405_6 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play910601102 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 910601102
		arg_406_1.duration_ = 7.77

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play910601103(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1084ui_story = arg_406_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_409_0 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 then
				arg_406_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_406_1.time_ - 0) / var_409_0)
				arg_406_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1084ui_story"].transform.position).z)
				arg_406_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1084ui_story"].transform.localEulerAngles = arg_406_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 then
				arg_406_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_406_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1084ui_story"].transform.position).z)
				arg_406_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1084ui_story"].transform.localEulerAngles = arg_406_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_409_1 = "1027ui_story"

			if arg_406_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_409_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_406_1.stage_.transform)

				var_409_2.name = var_409_1
				var_409_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_406_1.actors_[var_409_1] = var_409_2

				local var_409_3 = var_409_2:GetComponentInChildren(typeof(CharacterEffect))

				var_409_3.enabled = true

				local var_409_4 = GameObjectTools.GetOrAddComponent(var_409_2, typeof(DynamicBoneHelper))

				if var_409_4 then
					var_409_4:EnableDynamicBone(false)
				end

				arg_406_1:ShowWeapon(var_409_3.transform, false)

				arg_406_1.var_[var_409_1 .. "Animator"] = var_409_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_406_1.var_[var_409_1 .. "Animator"].applyRootMotion = true
				arg_406_1.var_[var_409_1 .. "LipSync"] = var_409_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_409_5 = arg_406_1.actors_["1027ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_5) and arg_406_1.var_.characterEffect1027ui_story == nil then
				arg_406_1.var_.characterEffect1027ui_story = var_409_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_6 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_6 and not isNil(var_409_5) then
				if arg_406_1.var_.characterEffect1027ui_story and not isNil(var_409_5) then
					arg_406_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_6 and arg_406_1.time_ < 0 + var_409_6 + arg_409_0 and not isNil(var_409_5) and arg_406_1.var_.characterEffect1027ui_story then
				arg_406_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_409_8 = "1080ui_story"

			if arg_406_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_409_9 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_406_1.stage_.transform)

				var_409_9.name = var_409_8
				var_409_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_406_1.actors_[var_409_8] = var_409_9

				local var_409_10 = var_409_9:GetComponentInChildren(typeof(CharacterEffect))

				var_409_10.enabled = true

				local var_409_11 = GameObjectTools.GetOrAddComponent(var_409_9, typeof(DynamicBoneHelper))

				if var_409_11 then
					var_409_11:EnableDynamicBone(false)
				end

				arg_406_1:ShowWeapon(var_409_10.transform, false)

				arg_406_1.var_[var_409_8 .. "Animator"] = var_409_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_406_1.var_[var_409_8 .. "Animator"].applyRootMotion = true
				arg_406_1.var_[var_409_8 .. "LipSync"] = var_409_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_409_12 = arg_406_1.actors_["1080ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_12) and arg_406_1.var_.characterEffect1080ui_story == nil then
				arg_406_1.var_.characterEffect1080ui_story = var_409_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_13 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_13 and not isNil(var_409_12) then
				if arg_406_1.var_.characterEffect1080ui_story and not isNil(var_409_12) then
					arg_406_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_406_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_13)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_13 and arg_406_1.time_ < 0 + var_409_13 + arg_409_0 and not isNil(var_409_12) and arg_406_1.var_.characterEffect1080ui_story then
				arg_406_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_406_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action3_1")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_409_14 = arg_406_1.actors_["1027ui_story"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1027ui_story = var_409_14.localPosition
			end

			local var_409_15 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_15 then
				var_409_14.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_406_1.time_ - 0) / var_409_15)
				var_409_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_14.position).x, (manager.ui.mainCamera.transform.position - var_409_14.position).y, (manager.ui.mainCamera.transform.position - var_409_14.position).z)
				var_409_14.localEulerAngles.z = 0
				var_409_14.localEulerAngles.x = 0
				var_409_14.localEulerAngles = var_409_14.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_15 and arg_406_1.time_ < 0 + var_409_15 + arg_409_0 then
				var_409_14.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_409_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_14.position).x, (manager.ui.mainCamera.transform.position - var_409_14.position).y, (manager.ui.mainCamera.transform.position - var_409_14.position).z)
				var_409_14.localEulerAngles.z = 0
				var_409_14.localEulerAngles.x = 0
				var_409_14.localEulerAngles = var_409_14.localEulerAngles
			end

			local var_409_16 = arg_406_1.actors_["1080ui_story"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1080ui_story = var_409_16.localPosition

				arg_406_1:ShowWeapon(arg_406_1.var_["1080ui_story" .. "Animator"].transform, false)
			end

			local var_409_17 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_17 then
				var_409_16.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_406_1.time_ - 0) / var_409_17)
				var_409_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_16.position).x, (manager.ui.mainCamera.transform.position - var_409_16.position).y, (manager.ui.mainCamera.transform.position - var_409_16.position).z)
				var_409_16.localEulerAngles.z = 0
				var_409_16.localEulerAngles.x = 0
				var_409_16.localEulerAngles = var_409_16.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_17 and arg_406_1.time_ < 0 + var_409_17 + arg_409_0 then
				var_409_16.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_409_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_409_16.position).x, (manager.ui.mainCamera.transform.position - var_409_16.position).y, (manager.ui.mainCamera.transform.position - var_409_16.position).z)
				var_409_16.localEulerAngles.z = 0
				var_409_16.localEulerAngles.x = 0
				var_409_16.localEulerAngles = var_409_16.localEulerAngles
			end

			local var_409_18 = 0
			local var_409_19 = 0.825

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_18 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_20 = arg_406_1:GetWordFromCfg(910601102)
				local var_409_21 = arg_406_1:FormatText(var_409_20.content)

				arg_406_1.text_.text = var_409_21

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_23 = 33 <= 0 and var_409_19 or var_409_19 * (utf8.len(var_409_21) / 33)

				if (33 <= 0 and var_409_19 or var_409_19 * (utf8.len(var_409_21) / 33)) > 0 and var_409_19 < var_409_23 then
					arg_406_1.talkMaxDuration = var_409_23

					if var_409_23 + var_409_18 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_23 + var_409_18
					end
				end

				arg_406_1.text_.text = var_409_21
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601102", "story_v_out_910601.awb") ~= 0 then
					local var_409_24 = manager.audio:GetVoiceLength("story_v_out_910601", "910601102", "story_v_out_910601.awb") / 1000

					if var_409_24 + var_409_18 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_24 + var_409_18
					end

					if var_409_20.prefab_name ~= "" and arg_406_1.actors_[var_409_20.prefab_name] ~= nil then
						local var_409_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_20.prefab_name].transform, "story_v_out_910601", "910601102", "story_v_out_910601.awb")

						arg_406_1:RecordAudio("910601102", var_409_25)
						arg_406_1:RecordAudio("910601102", var_409_25)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_910601", "910601102", "story_v_out_910601.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_910601", "910601102", "story_v_out_910601.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_26 = math.max(var_409_19, arg_406_1.talkMaxDuration)

			if var_409_18 <= arg_406_1.time_ and arg_406_1.time_ < var_409_18 + var_409_26 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_18) / var_409_26

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_18 + var_409_26 and arg_406_1.time_ < var_409_18 + var_409_26 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play910601103 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 910601103
		arg_410_1.duration_ = 2.73

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play910601104(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1080ui_story"]) and arg_410_1.var_.characterEffect1080ui_story == nil then
				arg_410_1.var_.characterEffect1080ui_story = arg_410_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1080ui_story"]) then
				if arg_410_1.var_.characterEffect1080ui_story and not isNil(arg_410_1.actors_["1080ui_story"]) then
					arg_410_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1080ui_story"]) and arg_410_1.var_.characterEffect1080ui_story then
				arg_410_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_413_2 = arg_410_1.actors_["1027ui_story"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.characterEffect1027ui_story == nil then
				arg_410_1.var_.characterEffect1027ui_story = var_413_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_3 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.characterEffect1027ui_story and not isNil(var_413_2) then
					arg_410_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_3)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.characterEffect1027ui_story then
				arg_410_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_413_4 = 0
			local var_413_5 = 0.275

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_4 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_6 = arg_410_1:GetWordFromCfg(910601103)
				local var_413_7 = arg_410_1:FormatText(var_413_6.content)

				arg_410_1.text_.text = var_413_7

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_9 = 11 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 11)

				if (11 <= 0 and var_413_5 or var_413_5 * (utf8.len(var_413_7) / 11)) > 0 and var_413_5 < var_413_9 then
					arg_410_1.talkMaxDuration = var_413_9

					if var_413_9 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_4
					end
				end

				arg_410_1.text_.text = var_413_7
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601103", "story_v_out_910601.awb") ~= 0 then
					local var_413_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601103", "story_v_out_910601.awb") / 1000

					if var_413_10 + var_413_4 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_10 + var_413_4
					end

					if var_413_6.prefab_name ~= "" and arg_410_1.actors_[var_413_6.prefab_name] ~= nil then
						local var_413_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_6.prefab_name].transform, "story_v_out_910601", "910601103", "story_v_out_910601.awb")

						arg_410_1:RecordAudio("910601103", var_413_11)
						arg_410_1:RecordAudio("910601103", var_413_11)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_910601", "910601103", "story_v_out_910601.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_910601", "910601103", "story_v_out_910601.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_12 = math.max(var_413_5, arg_410_1.talkMaxDuration)

			if var_413_4 <= arg_410_1.time_ and arg_410_1.time_ < var_413_4 + var_413_12 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_4) / var_413_12

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_4 + var_413_12 and arg_410_1.time_ < var_413_4 + var_413_12 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play910601104 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 910601104
		arg_414_1.duration_ = 3.07

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play910601105(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1027ui_story = arg_414_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1027ui_story"].transform.position).z)
				arg_414_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1027ui_story"].transform.localEulerAngles = arg_414_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_414_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1027ui_story"].transform.position).z)
				arg_414_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1027ui_story"].transform.localEulerAngles = arg_414_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["1080ui_story"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1080ui_story = var_417_1.localPosition

				arg_414_1:ShowWeapon(arg_414_1.var_["1080ui_story" .. "Animator"].transform, false)
			end

			local var_417_2 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_2 then
				var_417_1.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_414_1.time_ - 0) / var_417_2)
				var_417_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_1.position).x, (manager.ui.mainCamera.transform.position - var_417_1.position).y, (manager.ui.mainCamera.transform.position - var_417_1.position).z)
				var_417_1.localEulerAngles.z = 0
				var_417_1.localEulerAngles.x = 0
				var_417_1.localEulerAngles = var_417_1.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_2 and arg_414_1.time_ < 0 + var_417_2 + arg_417_0 then
				var_417_1.localPosition = Vector3.New(0, 100, 0)
				var_417_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_1.position).x, (manager.ui.mainCamera.transform.position - var_417_1.position).y, (manager.ui.mainCamera.transform.position - var_417_1.position).z)
				var_417_1.localEulerAngles.z = 0
				var_417_1.localEulerAngles.x = 0
				var_417_1.localEulerAngles = var_417_1.localEulerAngles
			end

			local var_417_3 = arg_414_1.actors_["1059ui_story"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1059ui_story = var_417_3.localPosition
			end

			local var_417_4 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				var_417_3.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_414_1.time_ - 0) / var_417_4)
				var_417_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_3.position).x, (manager.ui.mainCamera.transform.position - var_417_3.position).y, (manager.ui.mainCamera.transform.position - var_417_3.position).z)
				var_417_3.localEulerAngles.z = 0
				var_417_3.localEulerAngles.x = 0
				var_417_3.localEulerAngles = var_417_3.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				var_417_3.localPosition = Vector3.New(0, -1.05, -6)
				var_417_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_3.position).x, (manager.ui.mainCamera.transform.position - var_417_3.position).y, (manager.ui.mainCamera.transform.position - var_417_3.position).z)
				var_417_3.localEulerAngles.z = 0
				var_417_3.localEulerAngles.x = 0
				var_417_3.localEulerAngles = var_417_3.localEulerAngles
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_417_5 = arg_414_1.actors_["1059ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_5) and arg_414_1.var_.characterEffect1059ui_story == nil then
				arg_414_1.var_.characterEffect1059ui_story = var_417_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_6 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_6 and not isNil(var_417_5) then
				if arg_414_1.var_.characterEffect1059ui_story and not isNil(var_417_5) then
					arg_414_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_6 and arg_414_1.time_ < 0 + var_417_6 + arg_417_0 and not isNil(var_417_5) and arg_414_1.var_.characterEffect1059ui_story then
				arg_414_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_417_8 = 0
			local var_417_9 = 0.425

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_8 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_10 = arg_414_1:GetWordFromCfg(910601104)
				local var_417_11 = arg_414_1:FormatText(var_417_10.content)

				arg_414_1.text_.text = var_417_11

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_13 = 17 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 17)

				if (17 <= 0 and var_417_9 or var_417_9 * (utf8.len(var_417_11) / 17)) > 0 and var_417_9 < var_417_13 then
					arg_414_1.talkMaxDuration = var_417_13

					if var_417_13 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_13 + var_417_8
					end
				end

				arg_414_1.text_.text = var_417_11
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601104", "story_v_out_910601.awb") ~= 0 then
					local var_417_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601104", "story_v_out_910601.awb") / 1000

					if var_417_14 + var_417_8 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_14 + var_417_8
					end

					if var_417_10.prefab_name ~= "" and arg_414_1.actors_[var_417_10.prefab_name] ~= nil then
						local var_417_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_10.prefab_name].transform, "story_v_out_910601", "910601104", "story_v_out_910601.awb")

						arg_414_1:RecordAudio("910601104", var_417_15)
						arg_414_1:RecordAudio("910601104", var_417_15)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_910601", "910601104", "story_v_out_910601.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_910601", "910601104", "story_v_out_910601.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_16 = math.max(var_417_9, arg_414_1.talkMaxDuration)

			if var_417_8 <= arg_414_1.time_ and arg_414_1.time_ < var_417_8 + var_417_16 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_8) / var_417_16

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_8 + var_417_16 and arg_414_1.time_ < var_417_8 + var_417_16 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play910601105 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 910601105
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play910601106(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1059ui_story"]) and arg_418_1.var_.characterEffect1059ui_story == nil then
				arg_418_1.var_.characterEffect1059ui_story = arg_418_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1059ui_story"]) then
				if arg_418_1.var_.characterEffect1059ui_story and not isNil(arg_418_1.actors_["1059ui_story"]) then
					arg_418_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1059ui_story"]) and arg_418_1.var_.characterEffect1059ui_story then
				arg_418_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_421_1 = 0
			local var_421_2 = 0.35

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(910601105).content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 14 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 14)

				if (14 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 14)) > 0 and var_421_2 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_6 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_6 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_6

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_6 and arg_418_1.time_ < var_421_1 + var_421_6 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play910601106 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 910601106
		arg_422_1.duration_ = 7.87

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play910601107(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1059ui_story"]) and arg_422_1.var_.characterEffect1059ui_story == nil then
				arg_422_1.var_.characterEffect1059ui_story = arg_422_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1059ui_story"]) then
				if arg_422_1.var_.characterEffect1059ui_story and not isNil(arg_422_1.actors_["1059ui_story"]) then
					arg_422_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1059ui_story"]) and arg_422_1.var_.characterEffect1059ui_story then
				arg_422_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_425_2 = 0
			local var_425_3 = 0.775

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_4 = arg_422_1:GetWordFromCfg(910601106)
				local var_425_5 = arg_422_1:FormatText(var_425_4.content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_7 = 31 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 31)

				if (31 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 31)) > 0 and var_425_3 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_2
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601106", "story_v_out_910601.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601106", "story_v_out_910601.awb") / 1000

					if var_425_8 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_2
					end

					if var_425_4.prefab_name ~= "" and arg_422_1.actors_[var_425_4.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_4.prefab_name].transform, "story_v_out_910601", "910601106", "story_v_out_910601.awb")

						arg_422_1:RecordAudio("910601106", var_425_9)
						arg_422_1:RecordAudio("910601106", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_910601", "910601106", "story_v_out_910601.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_910601", "910601106", "story_v_out_910601.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_3, arg_422_1.talkMaxDuration)

			if var_425_2 <= arg_422_1.time_ and arg_422_1.time_ < var_425_2 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_2) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_2 + var_425_10 and arg_422_1.time_ < var_425_2 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play910601107 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 910601107
		arg_426_1.duration_ = 6.47

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play910601108(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_429_0 = 0
			local var_429_1 = 0.8

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_2 = arg_426_1:GetWordFromCfg(910601107)
				local var_429_3 = arg_426_1:FormatText(var_429_2.content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 32 <= 0 and var_429_1 or var_429_1 * (utf8.len(var_429_3) / 32)

				if (32 <= 0 and var_429_1 or var_429_1 * (utf8.len(var_429_3) / 32)) > 0 and var_429_1 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601107", "story_v_out_910601.awb") ~= 0 then
					local var_429_6 = manager.audio:GetVoiceLength("story_v_out_910601", "910601107", "story_v_out_910601.awb") / 1000

					if var_429_6 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_6 + var_429_0
					end

					if var_429_2.prefab_name ~= "" and arg_426_1.actors_[var_429_2.prefab_name] ~= nil then
						local var_429_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_2.prefab_name].transform, "story_v_out_910601", "910601107", "story_v_out_910601.awb")

						arg_426_1:RecordAudio("910601107", var_429_7)
						arg_426_1:RecordAudio("910601107", var_429_7)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_910601", "910601107", "story_v_out_910601.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_910601", "910601107", "story_v_out_910601.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_8 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_8 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_8

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_8 and arg_426_1.time_ < var_429_0 + var_429_8 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play910601108 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 910601108
		arg_430_1.duration_ = 4.6

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play910601109(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1059ui_story = arg_430_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1059ui_story"].transform.position).z)
				arg_430_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1059ui_story"].transform.localEulerAngles = arg_430_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_430_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1059ui_story"].transform.position).z)
				arg_430_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1059ui_story"].transform.localEulerAngles = arg_430_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["1048ui_story"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1048ui_story = var_433_1.localPosition
			end

			local var_433_2 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 then
				var_433_1.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_430_1.time_ - 0) / var_433_2)
				var_433_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_1.position).x, (manager.ui.mainCamera.transform.position - var_433_1.position).y, (manager.ui.mainCamera.transform.position - var_433_1.position).z)
				var_433_1.localEulerAngles.z = 0
				var_433_1.localEulerAngles.x = 0
				var_433_1.localEulerAngles = var_433_1.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 then
				var_433_1.localPosition = Vector3.New(0, -0.8, -6.2)
				var_433_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_1.position).x, (manager.ui.mainCamera.transform.position - var_433_1.position).y, (manager.ui.mainCamera.transform.position - var_433_1.position).z)
				var_433_1.localEulerAngles.z = 0
				var_433_1.localEulerAngles.x = 0
				var_433_1.localEulerAngles = var_433_1.localEulerAngles
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_433_3 = arg_430_1.actors_["1048ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_3) and arg_430_1.var_.characterEffect1048ui_story == nil then
				arg_430_1.var_.characterEffect1048ui_story = var_433_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_4 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 and not isNil(var_433_3) then
				if arg_430_1.var_.characterEffect1048ui_story and not isNil(var_433_3) then
					arg_430_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 and not isNil(var_433_3) and arg_430_1.var_.characterEffect1048ui_story then
				arg_430_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			local var_433_6 = 0
			local var_433_7 = 0.45

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_8 = arg_430_1:GetWordFromCfg(910601108)
				local var_433_9 = arg_430_1:FormatText(var_433_8.content)

				arg_430_1.text_.text = var_433_9

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 18 <= 0 and var_433_7 or var_433_7 * (utf8.len(var_433_9) / 18)

				if (18 <= 0 and var_433_7 or var_433_7 * (utf8.len(var_433_9) / 18)) > 0 and var_433_7 < var_433_11 then
					arg_430_1.talkMaxDuration = var_433_11

					if var_433_11 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_11 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_9
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601108", "story_v_out_910601.awb") ~= 0 then
					local var_433_12 = manager.audio:GetVoiceLength("story_v_out_910601", "910601108", "story_v_out_910601.awb") / 1000

					if var_433_12 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_12 + var_433_6
					end

					if var_433_8.prefab_name ~= "" and arg_430_1.actors_[var_433_8.prefab_name] ~= nil then
						local var_433_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_8.prefab_name].transform, "story_v_out_910601", "910601108", "story_v_out_910601.awb")

						arg_430_1:RecordAudio("910601108", var_433_13)
						arg_430_1:RecordAudio("910601108", var_433_13)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_910601", "910601108", "story_v_out_910601.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_910601", "910601108", "story_v_out_910601.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_14 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_14 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_14

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_14 and arg_430_1.time_ < var_433_6 + var_433_14 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play910601109 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 910601109
		arg_434_1.duration_ = 2.67

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play910601110(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1048ui_story = arg_434_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1048ui_story"].transform.position).z)
				arg_434_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1048ui_story"].transform.localEulerAngles = arg_434_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_434_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1048ui_story"].transform.position).z)
				arg_434_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1048ui_story"].transform.localEulerAngles = arg_434_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_437_1 = arg_434_1.actors_["1084ui_story"].transform

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1084ui_story = var_437_1.localPosition
			end

			local var_437_2 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 then
				var_437_1.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_434_1.time_ - 0) / var_437_2)
				var_437_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_1.position).x, (manager.ui.mainCamera.transform.position - var_437_1.position).y, (manager.ui.mainCamera.transform.position - var_437_1.position).z)
				var_437_1.localEulerAngles.z = 0
				var_437_1.localEulerAngles.x = 0
				var_437_1.localEulerAngles = var_437_1.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 then
				var_437_1.localPosition = Vector3.New(0, -0.97, -6)
				var_437_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_437_1.position).x, (manager.ui.mainCamera.transform.position - var_437_1.position).y, (manager.ui.mainCamera.transform.position - var_437_1.position).z)
				var_437_1.localEulerAngles.z = 0
				var_437_1.localEulerAngles.x = 0
				var_437_1.localEulerAngles = var_437_1.localEulerAngles
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_437_3 = arg_434_1.actors_["1084ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_3) and arg_434_1.var_.characterEffect1084ui_story == nil then
				arg_434_1.var_.characterEffect1084ui_story = var_437_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_4 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 and not isNil(var_437_3) then
				if arg_434_1.var_.characterEffect1084ui_story and not isNil(var_437_3) then
					arg_434_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 and not isNil(var_437_3) and arg_434_1.var_.characterEffect1084ui_story then
				arg_434_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_437_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_434_1.bgmTxt_.text ~= var_437_8 and arg_434_1.bgmTxt_.text ~= "" then
						if arg_434_1.bgmTxt2_.text ~= "" then
							arg_434_1.bgmTxt_.text = arg_434_1.bgmTxt2_.text
						end

						arg_434_1.bgmTxt2_.text = var_437_8

						arg_434_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_434_1.bgmTxt_.text = var_437_8
						arg_434_1.bgmTxt2_.text = var_437_8
					end

					if arg_434_1.bgmTimer then
						arg_434_1.bgmTimer:Stop()

						arg_434_1.bgmTimer = nil
					end

					if arg_434_1.settingData.show_music_name == 1 then
						arg_434_1.musicController:SetSelectedState("show")
						arg_434_1.musicAnimator_:Play("open", 0, 0)

						if arg_434_1.settingData.music_time ~= 0 then
							arg_434_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_434_1.settingData.music_time), function()
								if arg_434_1 == nil or isNil(arg_434_1.bgmTxt_) then
									return
								end

								arg_434_1.musicController:SetSelectedState("hide")
								arg_434_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_437_9 = 0
			local var_437_10 = 0.175

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_9 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_11 = arg_434_1:GetWordFromCfg(910601109)
				local var_437_12 = arg_434_1:FormatText(var_437_11.content)

				arg_434_1.text_.text = var_437_12

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_14 = 7 <= 0 and var_437_10 or var_437_10 * (utf8.len(var_437_12) / 7)

				if (7 <= 0 and var_437_10 or var_437_10 * (utf8.len(var_437_12) / 7)) > 0 and var_437_10 < var_437_14 then
					arg_434_1.talkMaxDuration = var_437_14

					if var_437_14 + var_437_9 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_14 + var_437_9
					end
				end

				arg_434_1.text_.text = var_437_12
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601109", "story_v_out_910601.awb") ~= 0 then
					local var_437_15 = manager.audio:GetVoiceLength("story_v_out_910601", "910601109", "story_v_out_910601.awb") / 1000

					if var_437_15 + var_437_9 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_15 + var_437_9
					end

					if var_437_11.prefab_name ~= "" and arg_434_1.actors_[var_437_11.prefab_name] ~= nil then
						local var_437_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_11.prefab_name].transform, "story_v_out_910601", "910601109", "story_v_out_910601.awb")

						arg_434_1:RecordAudio("910601109", var_437_16)
						arg_434_1:RecordAudio("910601109", var_437_16)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_910601", "910601109", "story_v_out_910601.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_910601", "910601109", "story_v_out_910601.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_17 = math.max(var_437_10, arg_434_1.talkMaxDuration)

			if var_437_9 <= arg_434_1.time_ and arg_434_1.time_ < var_437_9 + var_437_17 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_9) / var_437_17

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_9 + var_437_17 and arg_434_1.time_ < var_437_9 + var_437_17 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play910601110 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 910601110
		arg_439_1.duration_ = 2

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play910601111(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1084ui_story = arg_439_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_442_0 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				arg_439_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).z)
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles = arg_439_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				arg_439_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_439_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_439_1.actors_["1084ui_story"].transform.position).z)
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_439_1.actors_["1084ui_story"].transform.localEulerAngles = arg_439_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_442_1 = arg_439_1.actors_["1011ui_story"].transform

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos1011ui_story = var_442_1.localPosition
			end

			local var_442_2 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_2 then
				var_442_1.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_439_1.time_ - 0) / var_442_2)
				var_442_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_442_1.position).x, (manager.ui.mainCamera.transform.position - var_442_1.position).y, (manager.ui.mainCamera.transform.position - var_442_1.position).z)
				var_442_1.localEulerAngles.z = 0
				var_442_1.localEulerAngles.x = 0
				var_442_1.localEulerAngles = var_442_1.localEulerAngles
			end

			if arg_439_1.time_ >= 0 + var_442_2 and arg_439_1.time_ < 0 + var_442_2 + arg_442_0 then
				var_442_1.localPosition = Vector3.New(0, -0.71, -6)
				var_442_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_442_1.position).x, (manager.ui.mainCamera.transform.position - var_442_1.position).y, (manager.ui.mainCamera.transform.position - var_442_1.position).z)
				var_442_1.localEulerAngles.z = 0
				var_442_1.localEulerAngles.x = 0
				var_442_1.localEulerAngles = var_442_1.localEulerAngles
			end

			local var_442_3 = arg_439_1.actors_["1011ui_story"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_3) and arg_439_1.var_.characterEffect1011ui_story == nil then
				arg_439_1.var_.characterEffect1011ui_story = var_442_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_4 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_4 and not isNil(var_442_3) then
				if arg_439_1.var_.characterEffect1011ui_story and not isNil(var_442_3) then
					arg_439_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= 0 + var_442_4 and arg_439_1.time_ < 0 + var_442_4 + arg_442_0 and not isNil(var_442_3) and arg_439_1.var_.characterEffect1011ui_story then
				arg_439_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_442_6 = 0
			local var_442_7 = 0.225

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_8 = arg_439_1:GetWordFromCfg(910601110)
				local var_442_9 = arg_439_1:FormatText(var_442_8.content)

				arg_439_1.text_.text = var_442_9

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 9 <= 0 and var_442_7 or var_442_7 * (utf8.len(var_442_9) / 9)

				if (9 <= 0 and var_442_7 or var_442_7 * (utf8.len(var_442_9) / 9)) > 0 and var_442_7 < var_442_11 then
					arg_439_1.talkMaxDuration = var_442_11

					if var_442_11 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_11 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_9
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601110", "story_v_out_910601.awb") ~= 0 then
					local var_442_12 = manager.audio:GetVoiceLength("story_v_out_910601", "910601110", "story_v_out_910601.awb") / 1000

					if var_442_12 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_12 + var_442_6
					end

					if var_442_8.prefab_name ~= "" and arg_439_1.actors_[var_442_8.prefab_name] ~= nil then
						local var_442_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_8.prefab_name].transform, "story_v_out_910601", "910601110", "story_v_out_910601.awb")

						arg_439_1:RecordAudio("910601110", var_442_13)
						arg_439_1:RecordAudio("910601110", var_442_13)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_910601", "910601110", "story_v_out_910601.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_910601", "910601110", "story_v_out_910601.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_14 and arg_439_1.time_ < var_442_6 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play910601111 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 910601111
		arg_443_1.duration_ = 1.8

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play910601112(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1011ui_story = arg_443_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1011ui_story"].transform.position).z)
				arg_443_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1011ui_story"].transform.localEulerAngles = arg_443_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_443_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1011ui_story"].transform.position).z)
				arg_443_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1011ui_story"].transform.localEulerAngles = arg_443_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_446_1 = 0
			local var_446_2 = 0.375

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:GetWordFromCfg(910601111)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_6 = 15 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_4) / 15)

				if (15 <= 0 and var_446_2 or var_446_2 * (utf8.len(var_446_4) / 15)) > 0 and var_446_2 < var_446_6 then
					arg_443_1.talkMaxDuration = var_446_6

					if var_446_6 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_6 + var_446_1
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601111", "story_v_out_910601.awb") ~= 0 then
					local var_446_7 = manager.audio:GetVoiceLength("story_v_out_910601", "910601111", "story_v_out_910601.awb") / 1000

					if var_446_7 + var_446_1 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_1
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_910601", "910601111", "story_v_out_910601.awb")

						arg_443_1:RecordAudio("910601111", var_446_8)
						arg_443_1:RecordAudio("910601111", var_446_8)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_910601", "910601111", "story_v_out_910601.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_910601", "910601111", "story_v_out_910601.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_9 = math.max(var_446_2, arg_443_1.talkMaxDuration)

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_9 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_1) / var_446_9

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_1 + var_446_9 and arg_443_1.time_ < var_446_1 + var_446_9 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play910601112 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 910601112
		arg_447_1.duration_ = 39.17

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play910601121(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				SetActive(arg_447_1.dialog_, false)
				SetActive(arg_447_1.allBtn_.gameObject, false)
				arg_447_1.hideBtnsController_:SetSelectedIndex(1)
				arg_447_1:StopAllVoice()

				arg_447_1.marker = "dontskip1"

				manager.video:Play("SofdecAsset/story/story_9106010.usm", function(arg_451_0)
					if arg_447_1.state_ == "playing" then
						arg_447_1:JumpToEnd()
					end

					if arg_447_1.playNext_ and not arg_447_1.auto_ then
						arg_447_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_452_0)
					arg_447_1.state_ = arg_452_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_450_0 = 39.1666666666667

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				-- block empty
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.marker = ""
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play910601121 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 910601121
		arg_453_1.duration_ = 9

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play910601122(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 2 < arg_453_1.time_ and arg_453_1.time_ <= 2 + arg_456_0 then
				local var_456_0 = arg_453_1.bgs_.ST60

				arg_453_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_456_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_456_1 = var_456_0:GetComponent("SpriteRenderer")

				if var_456_1 and var_456_1.sprite then
					local var_456_2 = 2 * (var_456_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_456_0.transform.localScale = Vector3.New(var_456_2 / var_456_1.sprite.bounds.size.y < var_456_2 * manager.ui.mainCameraCom_.aspect / var_456_1.sprite.bounds.size.x and var_456_2 * manager.ui.mainCameraCom_.aspect / var_456_1.sprite.bounds.size.x or var_456_2 / var_456_1.sprite.bounds.size.y, var_456_2 / var_456_1.sprite.bounds.size.y < var_456_2 * manager.ui.mainCameraCom_.aspect / var_456_1.sprite.bounds.size.x and var_456_2 * manager.ui.mainCameraCom_.aspect / var_456_1.sprite.bounds.size.x or var_456_2 / var_456_1.sprite.bounds.size.y, 0)
				end

				for iter_456_0, iter_456_1 in pairs(arg_453_1.bgs_) do
					if iter_456_0 ~= "ST60" then
						iter_456_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_456_3 = 0

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_3 + arg_456_0 then
				arg_453_1.mask_.enabled = true
				arg_453_1.mask_.raycastTarget = true

				arg_453_1:SetGaussion(false)
			end

			local var_456_4 = 2

			if var_456_3 <= arg_453_1.time_ and arg_453_1.time_ < var_456_3 + var_456_4 then
				local var_456_5 = Color.New(1, 1, 1)

				var_456_5.a = Mathf.Lerp(0, 1, (arg_453_1.time_ - var_456_3) / var_456_4)
				arg_453_1.mask_.color = var_456_5
			end

			if arg_453_1.time_ >= var_456_3 + var_456_4 and arg_453_1.time_ < var_456_3 + var_456_4 + arg_456_0 then
				local var_456_6 = Color.New(1, 1, 1)

				var_456_6.a = 1
				arg_453_1.mask_.color = var_456_6
			end

			local var_456_7 = 2

			if 2 < arg_453_1.time_ and arg_453_1.time_ <= var_456_7 + arg_456_0 then
				arg_453_1.mask_.enabled = true
				arg_453_1.mask_.raycastTarget = true

				arg_453_1:SetGaussion(false)
			end

			local var_456_8 = 2

			if var_456_7 <= arg_453_1.time_ and arg_453_1.time_ < var_456_7 + var_456_8 then
				local var_456_9 = Color.New(1, 1, 1)

				var_456_9.a = Mathf.Lerp(1, 0, (arg_453_1.time_ - var_456_7) / var_456_8)
				arg_453_1.mask_.color = var_456_9
			end

			if arg_453_1.time_ >= var_456_7 + var_456_8 and arg_453_1.time_ < var_456_7 + var_456_8 + arg_456_0 then
				local var_456_10 = Color.New(1, 1, 1)

				arg_453_1.mask_.enabled = false
				var_456_10.a = 0
				arg_453_1.mask_.color = var_456_10
			end

			local var_456_11 = 2

			if 2 < arg_453_1.time_ and arg_453_1.time_ <= var_456_11 + arg_456_0 then
				SetActive(arg_453_1.dialog_, true)
				SetActive(arg_453_1.allBtn_.gameObject, true)
				arg_453_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_453_1.isInLoopVideo = false
			end

			local var_456_12 = 2

			if var_456_11 <= arg_453_1.time_ and arg_453_1.time_ < var_456_11 + var_456_12 then
				-- block empty
			end

			if arg_453_1.time_ >= var_456_11 + var_456_12 and arg_453_1.time_ < var_456_11 + var_456_12 + arg_456_0 then
				arg_453_1.marker = ""
			end

			if arg_453_1.frameCnt_ <= 1 then
				arg_453_1.dialog_:SetActive(false)
			end

			local var_456_13 = 4
			local var_456_14 = 0.075

			if 4 < arg_453_1.time_ and arg_453_1.time_ <= var_456_13 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0

				arg_453_1.dialog_:SetActive(true)

				arg_453_1.dialogCg_.alpha = 0

				local var_456_15 = LeanTween.value(arg_453_1.dialog_, 0, 1, 0.3)

				var_456_15:setOnUpdate(LuaHelper.FloatAction(function(arg_457_0)
					arg_453_1.dialogCg_.alpha = arg_457_0
				end))
				var_456_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_453_1.dialog_)
					var_456_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_453_1.duration_ = arg_453_1.duration_ + 0.3

				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_16 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(910601121).content)

				arg_453_1.text_.text = var_456_16

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_18 = 3 <= 0 and var_456_14 or var_456_14 * (utf8.len(var_456_16) / 3)

				if (3 <= 0 and var_456_14 or var_456_14 * (utf8.len(var_456_16) / 3)) > 0 and var_456_14 < var_456_18 then
					arg_453_1.talkMaxDuration = var_456_18
					var_456_13 = var_456_13 + 0.3

					if var_456_18 + var_456_13 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_18 + var_456_13
					end
				end

				arg_453_1.text_.text = var_456_16
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_19 = var_456_13 + 0.3
			local var_456_20 = math.max(var_456_14, arg_453_1.talkMaxDuration)

			if var_456_13 + 0.3 <= arg_453_1.time_ and arg_453_1.time_ < var_456_19 + var_456_20 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_19) / var_456_20

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_19 + var_456_20 and arg_453_1.time_ < var_456_19 + var_456_20 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play910601122 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 910601122
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play910601123(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0.325

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_459_1.callingController_:SetSelectedState("normal")

				arg_459_1.keyicon_.color = Color.New(1, 1, 1)
				arg_459_1.icon_.color = Color.New(1, 1, 1)

				local var_462_1 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(910601122).content)

				arg_459_1.text_.text = var_462_1

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_3 = 13 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 13)

				if (13 <= 0 and var_462_0 or var_462_0 * (utf8.len(var_462_1) / 13)) > 0 and var_462_0 < var_462_3 then
					arg_459_1.talkMaxDuration = var_462_3

					if var_462_3 + 0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_3 + 0
					end
				end

				arg_459_1.text_.text = var_462_1
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_4 = math.max(var_462_0, arg_459_1.talkMaxDuration)

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_4 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - 0) / var_462_4

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= 0 + var_462_4 and arg_459_1.time_ < 0 + var_462_4 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play910601123 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 910601123
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play910601124(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0.75

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_1 = arg_463_1:FormatText(arg_463_1:GetWordFromCfg(910601123).content)

				arg_463_1.text_.text = var_466_1

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_3 = 30 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 30)

				if (30 <= 0 and var_466_0 or var_466_0 * (utf8.len(var_466_1) / 30)) > 0 and var_466_0 < var_466_3 then
					arg_463_1.talkMaxDuration = var_466_3

					if var_466_3 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_3 + 0
					end
				end

				arg_463_1.text_.text = var_466_1
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_4 = math.max(var_466_0, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_4 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - 0) / var_466_4

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_4 and arg_463_1.time_ < 0 + var_466_4 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play910601124 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 910601124
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play910601125(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0.7

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_1 = arg_467_1:FormatText(arg_467_1:GetWordFromCfg(910601124).content)

				arg_467_1.text_.text = var_470_1

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_3 = 28 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 28)

				if (28 <= 0 and var_470_0 or var_470_0 * (utf8.len(var_470_1) / 28)) > 0 and var_470_0 < var_470_3 then
					arg_467_1.talkMaxDuration = var_470_3

					if var_470_3 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_3 + 0
					end
				end

				arg_467_1.text_.text = var_470_1
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_4 = math.max(var_470_0, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_4 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - 0) / var_470_4

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_4 and arg_467_1.time_ < 0 + var_470_4 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play910601125 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 910601125
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play910601126(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_474_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_471_1.bgmTxt_.text ~= var_474_2 and arg_471_1.bgmTxt_.text ~= "" then
						if arg_471_1.bgmTxt2_.text ~= "" then
							arg_471_1.bgmTxt_.text = arg_471_1.bgmTxt2_.text
						end

						arg_471_1.bgmTxt2_.text = var_474_2

						arg_471_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_471_1.bgmTxt_.text = var_474_2
						arg_471_1.bgmTxt2_.text = var_474_2
					end

					if arg_471_1.bgmTimer then
						arg_471_1.bgmTimer:Stop()

						arg_471_1.bgmTimer = nil
					end

					if arg_471_1.settingData.show_music_name == 1 then
						arg_471_1.musicController:SetSelectedState("show")
						arg_471_1.musicAnimator_:Play("open", 0, 0)

						if arg_471_1.settingData.music_time ~= 0 then
							arg_471_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_471_1.settingData.music_time), function()
								if arg_471_1 == nil or isNil(arg_471_1.bgmTxt_) then
									return
								end

								arg_471_1.musicController:SetSelectedState("hide")
								arg_471_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.8 < arg_471_1.time_ and arg_471_1.time_ <= 0.8 + arg_474_0 then
				arg_471_1:AudioAction("play", "music", "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_474_5 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if "" ~= "" then
					if arg_471_1.bgmTxt_.text ~= var_474_5 and arg_471_1.bgmTxt_.text ~= "" then
						if arg_471_1.bgmTxt2_.text ~= "" then
							arg_471_1.bgmTxt_.text = arg_471_1.bgmTxt2_.text
						end

						arg_471_1.bgmTxt2_.text = var_474_5

						arg_471_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_471_1.bgmTxt_.text = var_474_5
						arg_471_1.bgmTxt2_.text = var_474_5
					end

					if arg_471_1.bgmTimer then
						arg_471_1.bgmTimer:Stop()

						arg_471_1.bgmTimer = nil
					end

					if arg_471_1.settingData.show_music_name == 1 then
						arg_471_1.musicController:SetSelectedState("show")
						arg_471_1.musicAnimator_:Play("open", 0, 0)

						if arg_471_1.settingData.music_time ~= 0 then
							arg_471_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_471_1.settingData.music_time), function()
								if arg_471_1 == nil or isNil(arg_471_1.bgmTxt_) then
									return
								end

								arg_471_1.musicController:SetSelectedState("hide")
								arg_471_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_474_6 = 0
			local var_474_7 = 0.625

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_8 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(910601125).content)

				arg_471_1.text_.text = var_474_8

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_10 = 25 <= 0 and var_474_7 or var_474_7 * (utf8.len(var_474_8) / 25)

				if (25 <= 0 and var_474_7 or var_474_7 * (utf8.len(var_474_8) / 25)) > 0 and var_474_7 < var_474_10 then
					arg_471_1.talkMaxDuration = var_474_10

					if var_474_10 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_10 + var_474_6
					end
				end

				arg_471_1.text_.text = var_474_8
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_11 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_11 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_11

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_11 and arg_471_1.time_ < var_474_6 + var_474_11 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play910601126 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 910601126
		arg_477_1.duration_ = 4

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play910601127(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1011ui_story = arg_477_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1011ui_story"].transform.position).z)
				arg_477_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1011ui_story"].transform.localEulerAngles = arg_477_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_477_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1011ui_story"].transform.position).z)
				arg_477_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1011ui_story"].transform.localEulerAngles = arg_477_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1011ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1011ui_story == nil then
				arg_477_1.var_.characterEffect1011ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1011ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1011ui_story then
				arg_477_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_480_4 = 0
			local var_480_5 = 0.325

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(910601126)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 13 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 13)

				if (13 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 13)) > 0 and var_480_5 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601126", "story_v_out_910601.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601126", "story_v_out_910601.awb") / 1000

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end

					if var_480_6.prefab_name ~= "" and arg_477_1.actors_[var_480_6.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_6.prefab_name].transform, "story_v_out_910601", "910601126", "story_v_out_910601.awb")

						arg_477_1:RecordAudio("910601126", var_480_11)
						arg_477_1:RecordAudio("910601126", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_910601", "910601126", "story_v_out_910601.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_910601", "910601126", "story_v_out_910601.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_12 and arg_477_1.time_ < var_480_4 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play910601127 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 910601127
		arg_481_1.duration_ = 2.5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play910601128(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1011ui_story = arg_481_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).z)
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles = arg_481_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_481_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).z)
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles = arg_481_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1084ui_story"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1084ui_story = var_484_1.localPosition
			end

			local var_484_2 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 then
				var_484_1.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_481_1.time_ - 0) / var_484_2)
				var_484_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_1.position).x, (manager.ui.mainCamera.transform.position - var_484_1.position).y, (manager.ui.mainCamera.transform.position - var_484_1.position).z)
				var_484_1.localEulerAngles.z = 0
				var_484_1.localEulerAngles.x = 0
				var_484_1.localEulerAngles = var_484_1.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 then
				var_484_1.localPosition = Vector3.New(0, -0.97, -6)
				var_484_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_1.position).x, (manager.ui.mainCamera.transform.position - var_484_1.position).y, (manager.ui.mainCamera.transform.position - var_484_1.position).z)
				var_484_1.localEulerAngles.z = 0
				var_484_1.localEulerAngles.x = 0
				var_484_1.localEulerAngles = var_484_1.localEulerAngles
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_3 = arg_481_1.actors_["1084ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_3) and arg_481_1.var_.characterEffect1084ui_story == nil then
				arg_481_1.var_.characterEffect1084ui_story = var_484_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_4 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 and not isNil(var_484_3) then
				if arg_481_1.var_.characterEffect1084ui_story and not isNil(var_484_3) then
					arg_481_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 and not isNil(var_484_3) and arg_481_1.var_.characterEffect1084ui_story then
				arg_481_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_484_6 = 0
			local var_484_7 = 0.35

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_8 = arg_481_1:GetWordFromCfg(910601127)
				local var_484_9 = arg_481_1:FormatText(var_484_8.content)

				arg_481_1.text_.text = var_484_9

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 14 <= 0 and var_484_7 or var_484_7 * (utf8.len(var_484_9) / 14)

				if (14 <= 0 and var_484_7 or var_484_7 * (utf8.len(var_484_9) / 14)) > 0 and var_484_7 < var_484_11 then
					arg_481_1.talkMaxDuration = var_484_11

					if var_484_11 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_11 + var_484_6
					end
				end

				arg_481_1.text_.text = var_484_9
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601127", "story_v_out_910601.awb") ~= 0 then
					local var_484_12 = manager.audio:GetVoiceLength("story_v_out_910601", "910601127", "story_v_out_910601.awb") / 1000

					if var_484_12 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_12 + var_484_6
					end

					if var_484_8.prefab_name ~= "" and arg_481_1.actors_[var_484_8.prefab_name] ~= nil then
						local var_484_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_8.prefab_name].transform, "story_v_out_910601", "910601127", "story_v_out_910601.awb")

						arg_481_1:RecordAudio("910601127", var_484_13)
						arg_481_1:RecordAudio("910601127", var_484_13)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_910601", "910601127", "story_v_out_910601.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_910601", "910601127", "story_v_out_910601.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_14 = math.max(var_484_7, arg_481_1.talkMaxDuration)

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_6) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_6 + var_484_14 and arg_481_1.time_ < var_484_6 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play910601128 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 910601128
		arg_485_1.duration_ = 4

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play910601129(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1084ui_story"]) and arg_485_1.var_.characterEffect1084ui_story == nil then
				arg_485_1.var_.characterEffect1084ui_story = arg_485_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1084ui_story"]) then
				if arg_485_1.var_.characterEffect1084ui_story and not isNil(arg_485_1.actors_["1084ui_story"]) then
					arg_485_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1084ui_story"]) and arg_485_1.var_.characterEffect1084ui_story then
				arg_485_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_488_2 = 0
			local var_488_3 = 0.525

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(910601128)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 21 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 21)

				if (21 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 21)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601128", "story_v_out_910601.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601128", "story_v_out_910601.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_out_910601", "910601128", "story_v_out_910601.awb")

						arg_485_1:RecordAudio("910601128", var_488_9)
						arg_485_1:RecordAudio("910601128", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_910601", "910601128", "story_v_out_910601.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_910601", "910601128", "story_v_out_910601.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play910601129 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 910601129
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play910601130(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1084ui_story"]) and arg_489_1.var_.characterEffect1084ui_story == nil then
				arg_489_1.var_.characterEffect1084ui_story = arg_489_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1084ui_story"]) then
				if arg_489_1.var_.characterEffect1084ui_story and not isNil(arg_489_1.actors_["1084ui_story"]) then
					arg_489_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1084ui_story"]) and arg_489_1.var_.characterEffect1084ui_story then
				arg_489_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_492_1 = 0
			local var_492_2 = 1.3

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(910601129).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 52 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 52)

				if (52 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 52)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play910601130 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 910601130
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play910601131(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1084ui_story = arg_493_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1084ui_story"].transform.position).z)
				arg_493_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1084ui_story"].transform.localEulerAngles = arg_493_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_493_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1084ui_story"].transform.position).z)
				arg_493_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1084ui_story"].transform.localEulerAngles = arg_493_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1084ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1084ui_story == nil then
				arg_493_1.var_.characterEffect1084ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1084ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_2)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1084ui_story then
				arg_493_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_496_3 = 0
			local var_496_4 = 0.75

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_3 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_5 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(910601130).content)

				arg_493_1.text_.text = var_496_5

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_7 = 30 <= 0 and var_496_4 or var_496_4 * (utf8.len(var_496_5) / 30)

				if (30 <= 0 and var_496_4 or var_496_4 * (utf8.len(var_496_5) / 30)) > 0 and var_496_4 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_3 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_3
					end
				end

				arg_493_1.text_.text = var_496_5
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_8 = math.max(var_496_4, arg_493_1.talkMaxDuration)

			if var_496_3 <= arg_493_1.time_ and arg_493_1.time_ < var_496_3 + var_496_8 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_3) / var_496_8

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_3 + var_496_8 and arg_493_1.time_ < var_496_3 + var_496_8 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play910601131 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 910601131
		arg_497_1.duration_ = 7.83

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play910601132(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_500_0 = arg_497_1.actors_["1084ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1084ui_story == nil then
				arg_497_1.var_.characterEffect1084ui_story = var_500_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_1 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_1 and not isNil(var_500_0) then
				if arg_497_1.var_.characterEffect1084ui_story and not isNil(var_500_0) then
					arg_497_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_1 and arg_497_1.time_ < 0 + var_500_1 + arg_500_0 and not isNil(var_500_0) and arg_497_1.var_.characterEffect1084ui_story then
				arg_497_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_500_3 = 0
			local var_500_4 = 0.95

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_3 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_5 = arg_497_1:GetWordFromCfg(910601131)
				local var_500_6 = arg_497_1:FormatText(var_500_5.content)

				arg_497_1.text_.text = var_500_6

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_8 = 38 <= 0 and var_500_4 or var_500_4 * (utf8.len(var_500_6) / 38)

				if (38 <= 0 and var_500_4 or var_500_4 * (utf8.len(var_500_6) / 38)) > 0 and var_500_4 < var_500_8 then
					arg_497_1.talkMaxDuration = var_500_8

					if var_500_8 + var_500_3 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_3
					end
				end

				arg_497_1.text_.text = var_500_6
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601131", "story_v_out_910601.awb") ~= 0 then
					local var_500_9 = manager.audio:GetVoiceLength("story_v_out_910601", "910601131", "story_v_out_910601.awb") / 1000

					if var_500_9 + var_500_3 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_3
					end

					if var_500_5.prefab_name ~= "" and arg_497_1.actors_[var_500_5.prefab_name] ~= nil then
						local var_500_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_5.prefab_name].transform, "story_v_out_910601", "910601131", "story_v_out_910601.awb")

						arg_497_1:RecordAudio("910601131", var_500_10)
						arg_497_1:RecordAudio("910601131", var_500_10)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_910601", "910601131", "story_v_out_910601.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_910601", "910601131", "story_v_out_910601.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_11 = math.max(var_500_4, arg_497_1.talkMaxDuration)

			if var_500_3 <= arg_497_1.time_ and arg_497_1.time_ < var_500_3 + var_500_11 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_3) / var_500_11

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_3 + var_500_11 and arg_497_1.time_ < var_500_3 + var_500_11 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play910601132 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 910601132
		arg_501_1.duration_ = 2.03

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play910601133(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1084ui_story"]) and arg_501_1.var_.characterEffect1084ui_story == nil then
				arg_501_1.var_.characterEffect1084ui_story = arg_501_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1084ui_story"]) then
				if arg_501_1.var_.characterEffect1084ui_story and not isNil(arg_501_1.actors_["1084ui_story"]) then
					arg_501_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1084ui_story"]) and arg_501_1.var_.characterEffect1084ui_story then
				arg_501_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_504_2 = 0
			local var_504_3 = 0.175

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_2 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_4 = arg_501_1:GetWordFromCfg(910601132)
				local var_504_5 = arg_501_1:FormatText(var_504_4.content)

				arg_501_1.text_.text = var_504_5

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_7 = 7 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_5) / 7)

				if (7 <= 0 and var_504_3 or var_504_3 * (utf8.len(var_504_5) / 7)) > 0 and var_504_3 < var_504_7 then
					arg_501_1.talkMaxDuration = var_504_7

					if var_504_7 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_7 + var_504_2
					end
				end

				arg_501_1.text_.text = var_504_5
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601132", "story_v_out_910601.awb") ~= 0 then
					local var_504_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601132", "story_v_out_910601.awb") / 1000

					if var_504_8 + var_504_2 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_2
					end

					if var_504_4.prefab_name ~= "" and arg_501_1.actors_[var_504_4.prefab_name] ~= nil then
						local var_504_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_4.prefab_name].transform, "story_v_out_910601", "910601132", "story_v_out_910601.awb")

						arg_501_1:RecordAudio("910601132", var_504_9)
						arg_501_1:RecordAudio("910601132", var_504_9)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_910601", "910601132", "story_v_out_910601.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_910601", "910601132", "story_v_out_910601.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_10 = math.max(var_504_3, arg_501_1.talkMaxDuration)

			if var_504_2 <= arg_501_1.time_ and arg_501_1.time_ < var_504_2 + var_504_10 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_2) / var_504_10

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_2 + var_504_10 and arg_501_1.time_ < var_504_2 + var_504_10 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play910601133 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 910601133
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play910601134(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1084ui_story"]) and arg_505_1.var_.characterEffect1084ui_story == nil then
				arg_505_1.var_.characterEffect1084ui_story = arg_505_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1084ui_story"]) then
				if arg_505_1.var_.characterEffect1084ui_story and not isNil(arg_505_1.actors_["1084ui_story"]) then
					arg_505_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_0)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1084ui_story"]) and arg_505_1.var_.characterEffect1084ui_story then
				arg_505_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_508_1 = 0
			local var_508_2 = 0.775

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_3 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(910601133).content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 31 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 31)

				if (31 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 31)) > 0 and var_508_2 < var_508_5 then
					arg_505_1.talkMaxDuration = var_508_5

					if var_508_5 + var_508_1 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + var_508_1
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_6 = math.max(var_508_2, arg_505_1.talkMaxDuration)

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_6 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_1) / var_508_6

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_1 + var_508_6 and arg_505_1.time_ < var_508_1 + var_508_6 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play910601134 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 910601134
		arg_509_1.duration_ = 6.23

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play910601135(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1048ui_story = arg_509_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1048ui_story"].transform.position).z)
				arg_509_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1048ui_story"].transform.localEulerAngles = arg_509_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_509_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1048ui_story"].transform.position).z)
				arg_509_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1048ui_story"].transform.localEulerAngles = arg_509_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_512_1 = arg_509_1.actors_["1048ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1048ui_story == nil then
				arg_509_1.var_.characterEffect1048ui_story = var_512_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_2 and not isNil(var_512_1) then
				if arg_509_1.var_.characterEffect1048ui_story and not isNil(var_512_1) then
					arg_509_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= 0 + var_512_2 and arg_509_1.time_ < 0 + var_512_2 + arg_512_0 and not isNil(var_512_1) and arg_509_1.var_.characterEffect1048ui_story then
				arg_509_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_512_4 = arg_509_1.actors_["1084ui_story"].transform

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1084ui_story = var_512_4.localPosition
			end

			local var_512_5 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_5 then
				var_512_4.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_509_1.time_ - 0) / var_512_5)
				var_512_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_512_4.position).x, (manager.ui.mainCamera.transform.position - var_512_4.position).y, (manager.ui.mainCamera.transform.position - var_512_4.position).z)
				var_512_4.localEulerAngles.z = 0
				var_512_4.localEulerAngles.x = 0
				var_512_4.localEulerAngles = var_512_4.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_5 and arg_509_1.time_ < 0 + var_512_5 + arg_512_0 then
				var_512_4.localPosition = Vector3.New(0, 100, 0)
				var_512_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_512_4.position).x, (manager.ui.mainCamera.transform.position - var_512_4.position).y, (manager.ui.mainCamera.transform.position - var_512_4.position).z)
				var_512_4.localEulerAngles.z = 0
				var_512_4.localEulerAngles.x = 0
				var_512_4.localEulerAngles = var_512_4.localEulerAngles
			end

			local var_512_6 = arg_509_1.actors_["1084ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_6) and arg_509_1.var_.characterEffect1084ui_story == nil then
				arg_509_1.var_.characterEffect1084ui_story = var_512_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_7 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 and not isNil(var_512_6) then
				if arg_509_1.var_.characterEffect1084ui_story and not isNil(var_512_6) then
					arg_509_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_7)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 and not isNil(var_512_6) and arg_509_1.var_.characterEffect1084ui_story then
				arg_509_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_512_8 = 0
			local var_512_9 = 0.8

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_8 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_10 = arg_509_1:GetWordFromCfg(910601134)
				local var_512_11 = arg_509_1:FormatText(var_512_10.content)

				arg_509_1.text_.text = var_512_11

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_13 = 32 <= 0 and var_512_9 or var_512_9 * (utf8.len(var_512_11) / 32)

				if (32 <= 0 and var_512_9 or var_512_9 * (utf8.len(var_512_11) / 32)) > 0 and var_512_9 < var_512_13 then
					arg_509_1.talkMaxDuration = var_512_13

					if var_512_13 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_13 + var_512_8
					end
				end

				arg_509_1.text_.text = var_512_11
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601134", "story_v_out_910601.awb") ~= 0 then
					local var_512_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601134", "story_v_out_910601.awb") / 1000

					if var_512_14 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_14 + var_512_8
					end

					if var_512_10.prefab_name ~= "" and arg_509_1.actors_[var_512_10.prefab_name] ~= nil then
						local var_512_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_10.prefab_name].transform, "story_v_out_910601", "910601134", "story_v_out_910601.awb")

						arg_509_1:RecordAudio("910601134", var_512_15)
						arg_509_1:RecordAudio("910601134", var_512_15)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_910601", "910601134", "story_v_out_910601.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_910601", "910601134", "story_v_out_910601.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_16 = math.max(var_512_9, arg_509_1.talkMaxDuration)

			if var_512_8 <= arg_509_1.time_ and arg_509_1.time_ < var_512_8 + var_512_16 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_8) / var_512_16

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_8 + var_512_16 and arg_509_1.time_ < var_512_8 + var_512_16 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_509_1:InitPlayNodeList()
	end,
	Play910601135 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 910601135
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play910601136(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1048ui_story"]) and arg_513_1.var_.characterEffect1048ui_story == nil then
				arg_513_1.var_.characterEffect1048ui_story = arg_513_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1048ui_story"]) then
				if arg_513_1.var_.characterEffect1048ui_story and not isNil(arg_513_1.actors_["1048ui_story"]) then
					arg_513_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_0)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1048ui_story"]) and arg_513_1.var_.characterEffect1048ui_story then
				arg_513_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_516_1 = 0
			local var_516_2 = 0.15

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(910601135).content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 6 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 6)

				if (6 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 6)) > 0 and var_516_2 < var_516_5 then
					arg_513_1.talkMaxDuration = var_516_5

					if var_516_5 + var_516_1 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + var_516_1
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_6 = math.max(var_516_2, arg_513_1.talkMaxDuration)

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_6 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_1) / var_516_6

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_1 + var_516_6 and arg_513_1.time_ < var_516_1 + var_516_6 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play910601136 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 910601136
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play910601137(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1048ui_story = arg_517_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_520_0 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 then
				arg_517_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_517_1.time_ - 0) / var_520_0)
				arg_517_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1048ui_story"].transform.position).z)
				arg_517_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1048ui_story"].transform.localEulerAngles = arg_517_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 then
				arg_517_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1048ui_story"].transform.position).z)
				arg_517_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1048ui_story"].transform.localEulerAngles = arg_517_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_520_1 = 0
			local var_520_2 = 0.125

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(910601136).content)

				arg_517_1.text_.text = var_520_3

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_5 = 5 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_3) / 5)

				if (5 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_3) / 5)) > 0 and var_520_2 < var_520_5 then
					arg_517_1.talkMaxDuration = var_520_5

					if var_520_5 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_3
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_6 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_6 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_6

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_6 and arg_517_1.time_ < var_520_1 + var_520_6 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play910601137 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 910601137
		arg_521_1.duration_ = 6.67

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play910601138(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.var_.moveOldPos1084ui_story = arg_521_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_524_0 = 0.001

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 then
				arg_521_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_521_1.time_ - 0) / var_524_0)
				arg_521_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1084ui_story"].transform.position).z)
				arg_521_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1084ui_story"].transform.localEulerAngles = arg_521_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 then
				arg_521_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_521_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_521_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_521_1.actors_["1084ui_story"].transform.position).z)
				arg_521_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_521_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_521_1.actors_["1084ui_story"].transform.localEulerAngles = arg_521_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_524_1 = arg_521_1.actors_["1084ui_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1084ui_story == nil then
				arg_521_1.var_.characterEffect1084ui_story = var_524_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_2 and not isNil(var_524_1) then
				if arg_521_1.var_.characterEffect1084ui_story and not isNil(var_524_1) then
					arg_521_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_2 and arg_521_1.time_ < 0 + var_524_2 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1084ui_story then
				arg_521_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_524_4 = 0
			local var_524_5 = 0.7

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(910601137)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 28 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 28)

				if (28 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 28)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601137", "story_v_out_910601.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601137", "story_v_out_910601.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_out_910601", "910601137", "story_v_out_910601.awb")

						arg_521_1:RecordAudio("910601137", var_524_11)
						arg_521_1:RecordAudio("910601137", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_910601", "910601137", "story_v_out_910601.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_910601", "910601137", "story_v_out_910601.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_521_1:InitPlayNodeList()
	end,
	Play910601138 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 910601138
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play910601139(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["1084ui_story"]) and arg_525_1.var_.characterEffect1084ui_story == nil then
				arg_525_1.var_.characterEffect1084ui_story = arg_525_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["1084ui_story"]) then
				if arg_525_1.var_.characterEffect1084ui_story and not isNil(arg_525_1.actors_["1084ui_story"]) then
					arg_525_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_525_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_0)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["1084ui_story"]) and arg_525_1.var_.characterEffect1084ui_story then
				arg_525_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_525_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_528_1 = 0
			local var_528_2 = 0.35

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(910601138).content)

				arg_525_1.text_.text = var_528_3

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 14 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_3) / 14)

				if (14 <= 0 and var_528_2 or var_528_2 * (utf8.len(var_528_3) / 14)) > 0 and var_528_2 < var_528_5 then
					arg_525_1.talkMaxDuration = var_528_5

					if var_528_5 + var_528_1 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + var_528_1
					end
				end

				arg_525_1.text_.text = var_528_3
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_6 = math.max(var_528_2, arg_525_1.talkMaxDuration)

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_6 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_1) / var_528_6

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_1 + var_528_6 and arg_525_1.time_ < var_528_1 + var_528_6 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play910601139 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 910601139
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play910601140(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1084ui_story"]) and arg_529_1.var_.characterEffect1084ui_story == nil then
				arg_529_1.var_.characterEffect1084ui_story = arg_529_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1084ui_story"]) then
				if arg_529_1.var_.characterEffect1084ui_story and not isNil(arg_529_1.actors_["1084ui_story"]) then
					arg_529_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_0)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1084ui_story"]) and arg_529_1.var_.characterEffect1084ui_story then
				arg_529_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_532_1 = 0
			local var_532_2 = 0.575

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(910601139).content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 21 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 21)

				if (21 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_3) / 21)) > 0 and var_532_2 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_1
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_6 = math.max(var_532_2, arg_529_1.talkMaxDuration)

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_6 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_1) / var_532_6

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_1 + var_532_6 and arg_529_1.time_ < var_532_1 + var_532_6 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play910601140 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 910601140
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play910601141(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.35

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_1 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(910601140).content)

				arg_533_1.text_.text = var_536_1

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_3 = 14 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 14)

				if (14 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 14)) > 0 and var_536_0 < var_536_3 then
					arg_533_1.talkMaxDuration = var_536_3

					if var_536_3 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_3 + 0
					end
				end

				arg_533_1.text_.text = var_536_1
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_4 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_4

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play910601141 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 910601141
		arg_537_1.duration_ = 2

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play910601142(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["1084ui_story"]) and arg_537_1.var_.characterEffect1084ui_story == nil then
				arg_537_1.var_.characterEffect1084ui_story = arg_537_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_0 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["1084ui_story"]) then
				if arg_537_1.var_.characterEffect1084ui_story and not isNil(arg_537_1.actors_["1084ui_story"]) then
					arg_537_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_537_1.time_ - 0) / var_540_0)
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["1084ui_story"]) and arg_537_1.var_.characterEffect1084ui_story then
				arg_537_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_540_1 = 0
			local var_540_2 = 0.05

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_3 = arg_537_1:GetWordFromCfg(910601141)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_6 = 2 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_4) / 2)

				if (2 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_4) / 2)) > 0 and var_540_2 < var_540_6 then
					arg_537_1.talkMaxDuration = var_540_6

					if var_540_6 + var_540_1 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_1
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601141", "story_v_out_910601.awb") ~= 0 then
					local var_540_7 = manager.audio:GetVoiceLength("story_v_out_910601", "910601141", "story_v_out_910601.awb") / 1000

					if var_540_7 + var_540_1 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_1
					end

					if var_540_3.prefab_name ~= "" and arg_537_1.actors_[var_540_3.prefab_name] ~= nil then
						local var_540_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_3.prefab_name].transform, "story_v_out_910601", "910601141", "story_v_out_910601.awb")

						arg_537_1:RecordAudio("910601141", var_540_8)
						arg_537_1:RecordAudio("910601141", var_540_8)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_910601", "910601141", "story_v_out_910601.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_910601", "910601141", "story_v_out_910601.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_9 = math.max(var_540_2, arg_537_1.talkMaxDuration)

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_9 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_1) / var_540_9

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_1 + var_540_9 and arg_537_1.time_ < var_540_1 + var_540_9 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play910601142 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 910601142
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play910601143(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1084ui_story = arg_541_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).z)
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles = arg_541_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_541_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1084ui_story"].transform.position).z)
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1084ui_story"].transform.localEulerAngles = arg_541_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_544_1 = 0
			local var_544_2 = 1.35

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(910601142).content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 54 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 54)

				if (54 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 54)) > 0 and var_544_2 < var_544_5 then
					arg_541_1.talkMaxDuration = var_544_5

					if var_544_5 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_6 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_6 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_6

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_6 and arg_541_1.time_ < var_544_1 + var_544_6 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play910601143 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 910601143
		arg_545_1.duration_ = 4.83

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play910601144(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1084ui_story = arg_545_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1084ui_story"].transform.position).z)
				arg_545_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1084ui_story"].transform.localEulerAngles = arg_545_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_545_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1084ui_story"].transform.position).z)
				arg_545_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1084ui_story"].transform.localEulerAngles = arg_545_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_548_1 = arg_545_1.actors_["1084ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1084ui_story == nil then
				arg_545_1.var_.characterEffect1084ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1084ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1084ui_story then
				arg_545_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_548_4 = 0
			local var_548_5 = 0.5

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(910601143)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 20 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 20)

				if (20 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 20)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601143", "story_v_out_910601.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601143", "story_v_out_910601.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_out_910601", "910601143", "story_v_out_910601.awb")

						arg_545_1:RecordAudio("910601143", var_548_11)
						arg_545_1:RecordAudio("910601143", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_910601", "910601143", "story_v_out_910601.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_910601", "910601143", "story_v_out_910601.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_12 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_12 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_12

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_12 and arg_545_1.time_ < var_548_4 + var_548_12 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play910601144 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 910601144
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play910601145(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["1084ui_story"]) and arg_549_1.var_.characterEffect1084ui_story == nil then
				arg_549_1.var_.characterEffect1084ui_story = arg_549_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_0 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["1084ui_story"]) then
				if arg_549_1.var_.characterEffect1084ui_story and not isNil(arg_549_1.actors_["1084ui_story"]) then
					arg_549_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_0)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["1084ui_story"]) and arg_549_1.var_.characterEffect1084ui_story then
				arg_549_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_552_1 = 0
			local var_552_2 = 0.175

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(910601144).content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 7 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 7)

				if (7 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 7)) > 0 and var_552_2 < var_552_5 then
					arg_549_1.talkMaxDuration = var_552_5

					if var_552_5 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_6 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_6 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_6

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_6 and arg_549_1.time_ < var_552_1 + var_552_6 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play910601145 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 910601145
		arg_553_1.duration_ = 3.1

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play910601146(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1011ui_story = arg_553_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_556_0 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 then
				arg_553_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_553_1.time_ - 0) / var_556_0)
				arg_553_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).z)
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles = arg_553_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 then
				arg_553_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_553_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).z)
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles = arg_553_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_556_1 = arg_553_1.actors_["1011ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1011ui_story == nil then
				arg_553_1.var_.characterEffect1011ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect1011ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1011ui_story then
				arg_553_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_556_4 = arg_553_1.actors_["1084ui_story"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1084ui_story = var_556_4.localPosition
			end

			local var_556_5 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_5 then
				var_556_4.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_553_1.time_ - 0) / var_556_5)
				var_556_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_556_4.position).x, (manager.ui.mainCamera.transform.position - var_556_4.position).y, (manager.ui.mainCamera.transform.position - var_556_4.position).z)
				var_556_4.localEulerAngles.z = 0
				var_556_4.localEulerAngles.x = 0
				var_556_4.localEulerAngles = var_556_4.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_5 and arg_553_1.time_ < 0 + var_556_5 + arg_556_0 then
				var_556_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_556_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_556_4.position).x, (manager.ui.mainCamera.transform.position - var_556_4.position).y, (manager.ui.mainCamera.transform.position - var_556_4.position).z)
				var_556_4.localEulerAngles.z = 0
				var_556_4.localEulerAngles.x = 0
				var_556_4.localEulerAngles = var_556_4.localEulerAngles
			end

			local var_556_6 = arg_553_1.actors_["1084ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.characterEffect1084ui_story == nil then
				arg_553_1.var_.characterEffect1084ui_story = var_556_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_7 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_7 and not isNil(var_556_6) then
				if arg_553_1.var_.characterEffect1084ui_story and not isNil(var_556_6) then
					arg_553_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_7)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_7 and arg_553_1.time_ < 0 + var_556_7 + arg_556_0 and not isNil(var_556_6) and arg_553_1.var_.characterEffect1084ui_story then
				arg_553_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_556_8 = 0
			local var_556_9 = 0.3

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_8 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_10 = arg_553_1:GetWordFromCfg(910601145)
				local var_556_11 = arg_553_1:FormatText(var_556_10.content)

				arg_553_1.text_.text = var_556_11

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_13 = 12 <= 0 and var_556_9 or var_556_9 * (utf8.len(var_556_11) / 12)

				if (12 <= 0 and var_556_9 or var_556_9 * (utf8.len(var_556_11) / 12)) > 0 and var_556_9 < var_556_13 then
					arg_553_1.talkMaxDuration = var_556_13

					if var_556_13 + var_556_8 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_13 + var_556_8
					end
				end

				arg_553_1.text_.text = var_556_11
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601145", "story_v_out_910601.awb") ~= 0 then
					local var_556_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601145", "story_v_out_910601.awb") / 1000

					if var_556_14 + var_556_8 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_14 + var_556_8
					end

					if var_556_10.prefab_name ~= "" and arg_553_1.actors_[var_556_10.prefab_name] ~= nil then
						local var_556_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_10.prefab_name].transform, "story_v_out_910601", "910601145", "story_v_out_910601.awb")

						arg_553_1:RecordAudio("910601145", var_556_15)
						arg_553_1:RecordAudio("910601145", var_556_15)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_910601", "910601145", "story_v_out_910601.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_910601", "910601145", "story_v_out_910601.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_16 = math.max(var_556_9, arg_553_1.talkMaxDuration)

			if var_556_8 <= arg_553_1.time_ and arg_553_1.time_ < var_556_8 + var_556_16 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_8) / var_556_16

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_8 + var_556_16 and arg_553_1.time_ < var_556_8 + var_556_16 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play910601146 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 910601146
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play910601147(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1011ui_story"]) and arg_557_1.var_.characterEffect1011ui_story == nil then
				arg_557_1.var_.characterEffect1011ui_story = arg_557_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1011ui_story"]) then
				if arg_557_1.var_.characterEffect1011ui_story and not isNil(arg_557_1.actors_["1011ui_story"]) then
					arg_557_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_0)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1011ui_story"]) and arg_557_1.var_.characterEffect1011ui_story then
				arg_557_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_560_1 = arg_557_1.actors_["1084ui_story"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1084ui_story = var_560_1.localPosition
			end

			local var_560_2 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_2 then
				var_560_1.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_557_1.time_ - 0) / var_560_2)
				var_560_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_1.position).x, (manager.ui.mainCamera.transform.position - var_560_1.position).y, (manager.ui.mainCamera.transform.position - var_560_1.position).z)
				var_560_1.localEulerAngles.z = 0
				var_560_1.localEulerAngles.x = 0
				var_560_1.localEulerAngles = var_560_1.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_2 and arg_557_1.time_ < 0 + var_560_2 + arg_560_0 then
				var_560_1.localPosition = Vector3.New(0, 100, 0)
				var_560_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_1.position).x, (manager.ui.mainCamera.transform.position - var_560_1.position).y, (manager.ui.mainCamera.transform.position - var_560_1.position).z)
				var_560_1.localEulerAngles.z = 0
				var_560_1.localEulerAngles.x = 0
				var_560_1.localEulerAngles = var_560_1.localEulerAngles
			end

			local var_560_3 = arg_557_1.actors_["1011ui_story"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1011ui_story = var_560_3.localPosition
			end

			local var_560_4 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_4 then
				var_560_3.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_557_1.time_ - 0) / var_560_4)
				var_560_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_3.position).x, (manager.ui.mainCamera.transform.position - var_560_3.position).y, (manager.ui.mainCamera.transform.position - var_560_3.position).z)
				var_560_3.localEulerAngles.z = 0
				var_560_3.localEulerAngles.x = 0
				var_560_3.localEulerAngles = var_560_3.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_4 and arg_557_1.time_ < 0 + var_560_4 + arg_560_0 then
				var_560_3.localPosition = Vector3.New(0, 100, 0)
				var_560_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_3.position).x, (manager.ui.mainCamera.transform.position - var_560_3.position).y, (manager.ui.mainCamera.transform.position - var_560_3.position).z)
				var_560_3.localEulerAngles.z = 0
				var_560_3.localEulerAngles.x = 0
				var_560_3.localEulerAngles = var_560_3.localEulerAngles
			end

			local var_560_5 = 0
			local var_560_6 = 0.9

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_7 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(910601146).content)

				arg_557_1.text_.text = var_560_7

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_9 = 36 <= 0 and var_560_6 or var_560_6 * (utf8.len(var_560_7) / 36)

				if (36 <= 0 and var_560_6 or var_560_6 * (utf8.len(var_560_7) / 36)) > 0 and var_560_6 < var_560_9 then
					arg_557_1.talkMaxDuration = var_560_9

					if var_560_9 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_9 + var_560_5
					end
				end

				arg_557_1.text_.text = var_560_7
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_6, arg_557_1.talkMaxDuration)

			if var_560_5 <= arg_557_1.time_ and arg_557_1.time_ < var_560_5 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_5) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_5 + var_560_10 and arg_557_1.time_ < var_560_5 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play910601147 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 910601147
		arg_561_1.duration_ = 14.17

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play910601148(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1011ui_story = arg_561_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).z)
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles = arg_561_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_561_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1011ui_story"].transform.position).z)
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1011ui_story"].transform.localEulerAngles = arg_561_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_564_1 = arg_561_1.actors_["1011ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1011ui_story == nil then
				arg_561_1.var_.characterEffect1011ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1011ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1011ui_story then
				arg_561_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_564_4 = 0
			local var_564_5 = 1.525

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(910601147)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 61 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 61)

				if (61 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 61)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601147", "story_v_out_910601.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_out_910601", "910601147", "story_v_out_910601.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_out_910601", "910601147", "story_v_out_910601.awb")

						arg_561_1:RecordAudio("910601147", var_564_11)
						arg_561_1:RecordAudio("910601147", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_910601", "910601147", "story_v_out_910601.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_910601", "910601147", "story_v_out_910601.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play910601148 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 910601148
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play910601149(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1011ui_story"]) and arg_565_1.var_.characterEffect1011ui_story == nil then
				arg_565_1.var_.characterEffect1011ui_story = arg_565_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1011ui_story"]) then
				if arg_565_1.var_.characterEffect1011ui_story and not isNil(arg_565_1.actors_["1011ui_story"]) then
					arg_565_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1011ui_story"]) and arg_565_1.var_.characterEffect1011ui_story then
				arg_565_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_568_1 = 0
			local var_568_2 = 0.3

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(910601148).content)

				arg_565_1.text_.text = var_568_3

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 12 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 12)

				if (12 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 12)) > 0 and var_568_2 < var_568_5 then
					arg_565_1.talkMaxDuration = var_568_5

					if var_568_5 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_3
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_6 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_6 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_6

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_6 and arg_565_1.time_ < var_568_1 + var_568_6 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play910601149 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 910601149
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play910601150(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.var_.moveOldPos1011ui_story = arg_569_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_572_0 = 0.001

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 then
				arg_569_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_569_1.time_ - 0) / var_572_0)
				arg_569_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1011ui_story"].transform.position).z)
				arg_569_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1011ui_story"].transform.localEulerAngles = arg_569_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 then
				arg_569_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_569_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1011ui_story"].transform.position).z)
				arg_569_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1011ui_story"].transform.localEulerAngles = arg_569_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_572_1 = 0
			local var_572_2 = 0.525

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(910601149).content)

				arg_569_1.text_.text = var_572_3

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 21 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 21)

				if (21 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 21)) > 0 and var_572_2 < var_572_5 then
					arg_569_1.talkMaxDuration = var_572_5

					if var_572_5 + var_572_1 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + var_572_1
					end
				end

				arg_569_1.text_.text = var_572_3
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_6 = math.max(var_572_2, arg_569_1.talkMaxDuration)

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_6 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_1) / var_572_6

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_1 + var_572_6 and arg_569_1.time_ < var_572_1 + var_572_6 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play910601150 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 910601150
		arg_573_1.duration_ = 6.73

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play910601151(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1028ui_story = arg_573_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_576_0 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 then
				arg_573_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_573_1.time_ - 0) / var_576_0)
				arg_573_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1028ui_story"].transform.position).z)
				arg_573_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1028ui_story"].transform.localEulerAngles = arg_573_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 then
				arg_573_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, -0.9, -5.9)
				arg_573_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1028ui_story"].transform.position).z)
				arg_573_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1028ui_story"].transform.localEulerAngles = arg_573_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_576_1 = arg_573_1.actors_["1028ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_1) and arg_573_1.var_.characterEffect1028ui_story == nil then
				arg_573_1.var_.characterEffect1028ui_story = var_576_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_2 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_2 and not isNil(var_576_1) then
				if arg_573_1.var_.characterEffect1028ui_story and not isNil(var_576_1) then
					arg_573_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= 0 + var_576_2 and arg_573_1.time_ < 0 + var_576_2 + arg_576_0 and not isNil(var_576_1) and arg_573_1.var_.characterEffect1028ui_story then
				arg_573_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action3_1")
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_576_4 = arg_573_1.actors_["1084ui_story"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1084ui_story = var_576_4.localPosition
			end

			local var_576_5 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_5 then
				var_576_4.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_573_1.time_ - 0) / var_576_5)
				var_576_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_4.position).x, (manager.ui.mainCamera.transform.position - var_576_4.position).y, (manager.ui.mainCamera.transform.position - var_576_4.position).z)
				var_576_4.localEulerAngles.z = 0
				var_576_4.localEulerAngles.x = 0
				var_576_4.localEulerAngles = var_576_4.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_5 and arg_573_1.time_ < 0 + var_576_5 + arg_576_0 then
				var_576_4.localPosition = Vector3.New(0, 100, 0)
				var_576_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_4.position).x, (manager.ui.mainCamera.transform.position - var_576_4.position).y, (manager.ui.mainCamera.transform.position - var_576_4.position).z)
				var_576_4.localEulerAngles.z = 0
				var_576_4.localEulerAngles.x = 0
				var_576_4.localEulerAngles = var_576_4.localEulerAngles
			end

			local var_576_6 = arg_573_1.actors_["1084ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_6) and arg_573_1.var_.characterEffect1084ui_story == nil then
				arg_573_1.var_.characterEffect1084ui_story = var_576_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_7 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_7 and not isNil(var_576_6) then
				if arg_573_1.var_.characterEffect1084ui_story and not isNil(var_576_6) then
					arg_573_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_7)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_7 and arg_573_1.time_ < 0 + var_576_7 + arg_576_0 and not isNil(var_576_6) and arg_573_1.var_.characterEffect1084ui_story then
				arg_573_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_576_8 = 0
			local var_576_9 = 0.6

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_8 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_10 = arg_573_1:GetWordFromCfg(910601150)
				local var_576_11 = arg_573_1:FormatText(var_576_10.content)

				arg_573_1.text_.text = var_576_11

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_13 = 24 <= 0 and var_576_9 or var_576_9 * (utf8.len(var_576_11) / 24)

				if (24 <= 0 and var_576_9 or var_576_9 * (utf8.len(var_576_11) / 24)) > 0 and var_576_9 < var_576_13 then
					arg_573_1.talkMaxDuration = var_576_13

					if var_576_13 + var_576_8 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_13 + var_576_8
					end
				end

				arg_573_1.text_.text = var_576_11
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601150", "story_v_out_910601.awb") ~= 0 then
					local var_576_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601150", "story_v_out_910601.awb") / 1000

					if var_576_14 + var_576_8 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_14 + var_576_8
					end

					if var_576_10.prefab_name ~= "" and arg_573_1.actors_[var_576_10.prefab_name] ~= nil then
						local var_576_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_10.prefab_name].transform, "story_v_out_910601", "910601150", "story_v_out_910601.awb")

						arg_573_1:RecordAudio("910601150", var_576_15)
						arg_573_1:RecordAudio("910601150", var_576_15)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_910601", "910601150", "story_v_out_910601.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_910601", "910601150", "story_v_out_910601.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_16 = math.max(var_576_9, arg_573_1.talkMaxDuration)

			if var_576_8 <= arg_573_1.time_ and arg_573_1.time_ < var_576_8 + var_576_16 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_8) / var_576_16

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_8 + var_576_16 and arg_573_1.time_ < var_576_8 + var_576_16 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play910601151 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 910601151
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play910601152(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1028ui_story"]) and arg_577_1.var_.characterEffect1028ui_story == nil then
				arg_577_1.var_.characterEffect1028ui_story = arg_577_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1028ui_story"]) then
				if arg_577_1.var_.characterEffect1028ui_story and not isNil(arg_577_1.actors_["1028ui_story"]) then
					arg_577_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_0)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1028ui_story"]) and arg_577_1.var_.characterEffect1028ui_story then
				arg_577_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_580_1 = 0
			local var_580_2 = 0.55

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_3 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(910601151).content)

				arg_577_1.text_.text = var_580_3

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 22 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 22)

				if (22 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 22)) > 0 and var_580_2 < var_580_5 then
					arg_577_1.talkMaxDuration = var_580_5

					if var_580_5 + var_580_1 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + var_580_1
					end
				end

				arg_577_1.text_.text = var_580_3
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_6 = math.max(var_580_2, arg_577_1.talkMaxDuration)

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_6 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_1) / var_580_6

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_1 + var_580_6 and arg_577_1.time_ < var_580_1 + var_580_6 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play910601152 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 910601152
		arg_581_1.duration_ = 6.4

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play910601153(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["1028ui_story"]) and arg_581_1.var_.characterEffect1028ui_story == nil then
				arg_581_1.var_.characterEffect1028ui_story = arg_581_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_0 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["1028ui_story"]) then
				if arg_581_1.var_.characterEffect1028ui_story and not isNil(arg_581_1.actors_["1028ui_story"]) then
					arg_581_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["1028ui_story"]) and arg_581_1.var_.characterEffect1028ui_story then
				arg_581_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028actionlink/1028action434")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_584_2 = 0
			local var_584_3 = 0.8

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_2 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_4 = arg_581_1:GetWordFromCfg(910601152)
				local var_584_5 = arg_581_1:FormatText(var_584_4.content)

				arg_581_1.text_.text = var_584_5

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_7 = 32 <= 0 and var_584_3 or var_584_3 * (utf8.len(var_584_5) / 32)

				if (32 <= 0 and var_584_3 or var_584_3 * (utf8.len(var_584_5) / 32)) > 0 and var_584_3 < var_584_7 then
					arg_581_1.talkMaxDuration = var_584_7

					if var_584_7 + var_584_2 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_7 + var_584_2
					end
				end

				arg_581_1.text_.text = var_584_5
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601152", "story_v_out_910601.awb") ~= 0 then
					local var_584_8 = manager.audio:GetVoiceLength("story_v_out_910601", "910601152", "story_v_out_910601.awb") / 1000

					if var_584_8 + var_584_2 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_8 + var_584_2
					end

					if var_584_4.prefab_name ~= "" and arg_581_1.actors_[var_584_4.prefab_name] ~= nil then
						local var_584_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_4.prefab_name].transform, "story_v_out_910601", "910601152", "story_v_out_910601.awb")

						arg_581_1:RecordAudio("910601152", var_584_9)
						arg_581_1:RecordAudio("910601152", var_584_9)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_910601", "910601152", "story_v_out_910601.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_910601", "910601152", "story_v_out_910601.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_10 = math.max(var_584_3, arg_581_1.talkMaxDuration)

			if var_584_2 <= arg_581_1.time_ and arg_581_1.time_ < var_584_2 + var_584_10 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_2) / var_584_10

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_2 + var_584_10 and arg_581_1.time_ < var_584_2 + var_584_10 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play910601153 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 910601153
		arg_585_1.duration_ = 8.83

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play910601154(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.var_.moveOldPos1048ui_story = arg_585_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_588_0 = 0.001

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 then
				arg_585_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1048ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_585_1.time_ - 0) / var_588_0)
				arg_585_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_585_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1048ui_story"].transform.position).z)
				arg_585_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_585_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_585_1.actors_["1048ui_story"].transform.localEulerAngles = arg_585_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 then
				arg_585_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_585_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_585_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_585_1.actors_["1048ui_story"].transform.position).z)
				arg_585_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_585_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_585_1.actors_["1048ui_story"].transform.localEulerAngles = arg_585_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_588_1 = arg_585_1.actors_["1048ui_story"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1048ui_story == nil then
				arg_585_1.var_.characterEffect1048ui_story = var_588_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_2 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_2 and not isNil(var_588_1) then
				if arg_585_1.var_.characterEffect1048ui_story and not isNil(var_588_1) then
					arg_585_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= 0 + var_588_2 and arg_585_1.time_ < 0 + var_588_2 + arg_588_0 and not isNil(var_588_1) and arg_585_1.var_.characterEffect1048ui_story then
				arg_585_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action6_1")
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_588_4 = arg_585_1.actors_["1028ui_story"].transform

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.var_.moveOldPos1028ui_story = var_588_4.localPosition
			end

			local var_588_5 = 0.001

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_5 then
				var_588_4.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1028ui_story, Vector3.New(-0.7, -0.9, -5.9), (arg_585_1.time_ - 0) / var_588_5)
				var_588_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_588_4.position).x, (manager.ui.mainCamera.transform.position - var_588_4.position).y, (manager.ui.mainCamera.transform.position - var_588_4.position).z)
				var_588_4.localEulerAngles.z = 0
				var_588_4.localEulerAngles.x = 0
				var_588_4.localEulerAngles = var_588_4.localEulerAngles
			end

			if arg_585_1.time_ >= 0 + var_588_5 and arg_585_1.time_ < 0 + var_588_5 + arg_588_0 then
				var_588_4.localPosition = Vector3.New(-0.7, -0.9, -5.9)
				var_588_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_588_4.position).x, (manager.ui.mainCamera.transform.position - var_588_4.position).y, (manager.ui.mainCamera.transform.position - var_588_4.position).z)
				var_588_4.localEulerAngles.z = 0
				var_588_4.localEulerAngles.x = 0
				var_588_4.localEulerAngles = var_588_4.localEulerAngles
			end

			local var_588_6 = arg_585_1.actors_["1028ui_story"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_6) and arg_585_1.var_.characterEffect1028ui_story == nil then
				arg_585_1.var_.characterEffect1028ui_story = var_588_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_7 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_7 and not isNil(var_588_6) then
				if arg_585_1.var_.characterEffect1028ui_story and not isNil(var_588_6) then
					arg_585_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_585_1.time_ - 0) / var_588_7)
				end
			end

			if arg_585_1.time_ >= 0 + var_588_7 and arg_585_1.time_ < 0 + var_588_7 + arg_588_0 and not isNil(var_588_6) and arg_585_1.var_.characterEffect1028ui_story then
				arg_585_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action4_2")
			end

			local var_588_8 = 0
			local var_588_9 = 0.95

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_8 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_10 = arg_585_1:GetWordFromCfg(910601153)
				local var_588_11 = arg_585_1:FormatText(var_588_10.content)

				arg_585_1.text_.text = var_588_11

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_13 = 38 <= 0 and var_588_9 or var_588_9 * (utf8.len(var_588_11) / 38)

				if (38 <= 0 and var_588_9 or var_588_9 * (utf8.len(var_588_11) / 38)) > 0 and var_588_9 < var_588_13 then
					arg_585_1.talkMaxDuration = var_588_13

					if var_588_13 + var_588_8 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_13 + var_588_8
					end
				end

				arg_585_1.text_.text = var_588_11
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601153", "story_v_out_910601.awb") ~= 0 then
					local var_588_14 = manager.audio:GetVoiceLength("story_v_out_910601", "910601153", "story_v_out_910601.awb") / 1000

					if var_588_14 + var_588_8 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_14 + var_588_8
					end

					if var_588_10.prefab_name ~= "" and arg_585_1.actors_[var_588_10.prefab_name] ~= nil then
						local var_588_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_10.prefab_name].transform, "story_v_out_910601", "910601153", "story_v_out_910601.awb")

						arg_585_1:RecordAudio("910601153", var_588_15)
						arg_585_1:RecordAudio("910601153", var_588_15)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_910601", "910601153", "story_v_out_910601.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_910601", "910601153", "story_v_out_910601.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_16 = math.max(var_588_9, arg_585_1.talkMaxDuration)

			if var_588_8 <= arg_585_1.time_ and arg_585_1.time_ < var_588_8 + var_588_16 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_8) / var_588_16

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_8 + var_588_16 and arg_585_1.time_ < var_588_8 + var_588_16 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play910601154 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 910601154
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play910601155(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["1048ui_story"]) and arg_589_1.var_.characterEffect1048ui_story == nil then
				arg_589_1.var_.characterEffect1048ui_story = arg_589_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_0 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["1048ui_story"]) then
				if arg_589_1.var_.characterEffect1048ui_story and not isNil(arg_589_1.actors_["1048ui_story"]) then
					arg_589_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_589_1.time_ - 0) / var_592_0)
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["1048ui_story"]) and arg_589_1.var_.characterEffect1048ui_story then
				arg_589_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_592_1 = 0
			local var_592_2 = 0.525

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_3 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(910601154).content)

				arg_589_1.text_.text = var_592_3

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 21 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 21)

				if (21 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 21)) > 0 and var_592_2 < var_592_5 then
					arg_589_1.talkMaxDuration = var_592_5

					if var_592_5 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + var_592_1
					end
				end

				arg_589_1.text_.text = var_592_3
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_6 = math.max(var_592_2, arg_589_1.talkMaxDuration)

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_6 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_1) / var_592_6

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_1 + var_592_6 and arg_589_1.time_ < var_592_1 + var_592_6 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play910601155 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 910601155
		arg_593_1.duration_ = 8.98

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play910601156(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if arg_593_1.bgs_.XH0201 == nil then
				local var_596_0 = Object.Instantiate(arg_593_1.paintGo_)

				var_596_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0201")
				var_596_0.name = "XH0201"
				var_596_0.transform.parent = arg_593_1.stage_.transform
				var_596_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_593_1.bgs_.XH0201 = var_596_0
			end

			if 2 < arg_593_1.time_ and arg_593_1.time_ <= 2 + arg_596_0 then
				local var_596_1 = arg_593_1.bgs_.XH0201

				arg_593_1.bgs_.XH0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_596_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_596_2 = var_596_1:GetComponent("SpriteRenderer")

				if var_596_2 and var_596_2.sprite then
					local var_596_3 = 2 * (var_596_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_596_1.transform.localScale = Vector3.New(var_596_3 / var_596_2.sprite.bounds.size.y < var_596_3 * manager.ui.mainCameraCom_.aspect / var_596_2.sprite.bounds.size.x and var_596_3 * manager.ui.mainCameraCom_.aspect / var_596_2.sprite.bounds.size.x or var_596_3 / var_596_2.sprite.bounds.size.y, var_596_3 / var_596_2.sprite.bounds.size.y < var_596_3 * manager.ui.mainCameraCom_.aspect / var_596_2.sprite.bounds.size.x and var_596_3 * manager.ui.mainCameraCom_.aspect / var_596_2.sprite.bounds.size.x or var_596_3 / var_596_2.sprite.bounds.size.y, 0)
				end

				for iter_596_0, iter_596_1 in pairs(arg_593_1.bgs_) do
					if iter_596_0 ~= "XH0201" then
						iter_596_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_596_4 = 0

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.mask_.enabled = true
				arg_593_1.mask_.raycastTarget = true

				arg_593_1:SetGaussion(false)
			end

			local var_596_5 = 2

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_5 then
				local var_596_6 = Color.New(1, 0.9764151, 0.9764151)

				var_596_6.a = Mathf.Lerp(0, 1, (arg_593_1.time_ - var_596_4) / var_596_5)
				arg_593_1.mask_.color = var_596_6
			end

			if arg_593_1.time_ >= var_596_4 + var_596_5 and arg_593_1.time_ < var_596_4 + var_596_5 + arg_596_0 then
				local var_596_7 = Color.New(1, 0.9764151, 0.9764151)

				var_596_7.a = 1
				arg_593_1.mask_.color = var_596_7
			end

			local var_596_8 = 2

			if 2 < arg_593_1.time_ and arg_593_1.time_ <= var_596_8 + arg_596_0 then
				arg_593_1.mask_.enabled = true
				arg_593_1.mask_.raycastTarget = true

				arg_593_1:SetGaussion(false)
			end

			local var_596_9 = 2

			if var_596_8 <= arg_593_1.time_ and arg_593_1.time_ < var_596_8 + var_596_9 then
				local var_596_10 = Color.New(1, 0.9764151, 0.9764151)

				var_596_10.a = Mathf.Lerp(1, 0, (arg_593_1.time_ - var_596_8) / var_596_9)
				arg_593_1.mask_.color = var_596_10
			end

			if arg_593_1.time_ >= var_596_8 + var_596_9 and arg_593_1.time_ < var_596_8 + var_596_9 + arg_596_0 then
				local var_596_11 = Color.New(1, 0.9764151, 0.9764151)

				arg_593_1.mask_.enabled = false
				var_596_11.a = 0
				arg_593_1.mask_.color = var_596_11
			end

			local var_596_12 = arg_593_1.actors_["1048ui_story"].transform

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.moveOldPos1048ui_story = var_596_12.localPosition
			end

			local var_596_13 = 0.001

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_13 then
				var_596_12.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_593_1.time_ - 0) / var_596_13)
				var_596_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_596_12.position).x, (manager.ui.mainCamera.transform.position - var_596_12.position).y, (manager.ui.mainCamera.transform.position - var_596_12.position).z)
				var_596_12.localEulerAngles.z = 0
				var_596_12.localEulerAngles.x = 0
				var_596_12.localEulerAngles = var_596_12.localEulerAngles
			end

			if arg_593_1.time_ >= 0 + var_596_13 and arg_593_1.time_ < 0 + var_596_13 + arg_596_0 then
				var_596_12.localPosition = Vector3.New(0, 100, 0)
				var_596_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_596_12.position).x, (manager.ui.mainCamera.transform.position - var_596_12.position).y, (manager.ui.mainCamera.transform.position - var_596_12.position).z)
				var_596_12.localEulerAngles.z = 0
				var_596_12.localEulerAngles.x = 0
				var_596_12.localEulerAngles = var_596_12.localEulerAngles
			end

			local var_596_14 = arg_593_1.actors_["1048ui_story"]

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(var_596_14) and arg_593_1.var_.characterEffect1048ui_story == nil then
				arg_593_1.var_.characterEffect1048ui_story = var_596_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_15 = 0.034000001847744

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_15 and not isNil(var_596_14) then
				if arg_593_1.var_.characterEffect1048ui_story and not isNil(var_596_14) then
					arg_593_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_593_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_593_1.time_ - 0) / var_596_15)
				end
			end

			if arg_593_1.time_ >= 0 + var_596_15 and arg_593_1.time_ < 0 + var_596_15 + arg_596_0 and not isNil(var_596_14) and arg_593_1.var_.characterEffect1048ui_story then
				arg_593_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_593_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_596_16 = arg_593_1.actors_["1028ui_story"].transform

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.moveOldPos1028ui_story = var_596_16.localPosition
			end

			local var_596_17 = 0.001

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_17 then
				var_596_16.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_593_1.time_ - 0) / var_596_17)
				var_596_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_596_16.position).x, (manager.ui.mainCamera.transform.position - var_596_16.position).y, (manager.ui.mainCamera.transform.position - var_596_16.position).z)
				var_596_16.localEulerAngles.z = 0
				var_596_16.localEulerAngles.x = 0
				var_596_16.localEulerAngles = var_596_16.localEulerAngles
			end

			if arg_593_1.time_ >= 0 + var_596_17 and arg_593_1.time_ < 0 + var_596_17 + arg_596_0 then
				var_596_16.localPosition = Vector3.New(0, 100, 0)
				var_596_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_596_16.position).x, (manager.ui.mainCamera.transform.position - var_596_16.position).y, (manager.ui.mainCamera.transform.position - var_596_16.position).z)
				var_596_16.localEulerAngles.z = 0
				var_596_16.localEulerAngles.x = 0
				var_596_16.localEulerAngles = var_596_16.localEulerAngles
			end

			local var_596_18 = arg_593_1.actors_["1028ui_story"]

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(var_596_18) and arg_593_1.var_.characterEffect1028ui_story == nil then
				arg_593_1.var_.characterEffect1028ui_story = var_596_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_19 = 0.034000001847744

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_19 and not isNil(var_596_18) then
				if arg_593_1.var_.characterEffect1028ui_story and not isNil(var_596_18) then
					arg_593_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_593_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_593_1.time_ - 0) / var_596_19)
				end
			end

			if arg_593_1.time_ >= 0 + var_596_19 and arg_593_1.time_ < 0 + var_596_19 + arg_596_0 and not isNil(var_596_18) and arg_593_1.var_.characterEffect1028ui_story then
				arg_593_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_593_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			if arg_593_1.frameCnt_ <= 1 then
				arg_593_1.dialog_:SetActive(false)
			end

			local var_596_20 = 3.975
			local var_596_21 = 1.025

			if 3.975 < arg_593_1.time_ and arg_593_1.time_ <= var_596_20 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0

				arg_593_1.dialog_:SetActive(true)

				arg_593_1.dialogCg_.alpha = 0

				local var_596_22 = LeanTween.value(arg_593_1.dialog_, 0, 1, 0.3)

				var_596_22:setOnUpdate(LuaHelper.FloatAction(function(arg_597_0)
					arg_593_1.dialogCg_.alpha = arg_597_0
				end))
				var_596_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_593_1.dialog_)
					var_596_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_593_1.duration_ = arg_593_1.duration_ + 0.3

				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_23 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(910601155).content)

				arg_593_1.text_.text = var_596_23

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_25 = 41 <= 0 and var_596_21 or var_596_21 * (utf8.len(var_596_23) / 41)

				if (41 <= 0 and var_596_21 or var_596_21 * (utf8.len(var_596_23) / 41)) > 0 and var_596_21 < var_596_25 then
					arg_593_1.talkMaxDuration = var_596_25
					var_596_20 = var_596_20 + 0.3

					if var_596_25 + var_596_20 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_25 + var_596_20
					end
				end

				arg_593_1.text_.text = var_596_23
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_26 = var_596_20 + 0.3
			local var_596_27 = math.max(var_596_21, arg_593_1.talkMaxDuration)

			if var_596_20 + 0.3 <= arg_593_1.time_ and arg_593_1.time_ < var_596_26 + var_596_27 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_26) / var_596_27

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_26 + var_596_27 and arg_593_1.time_ < var_596_26 + var_596_27 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_593_1:InitPlayNodeList()
	end,
	Play910601156 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 910601156
		arg_599_1.duration_ = 8.98

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play910601157(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if arg_599_1.bgs_.R1102 == nil then
				local var_602_0 = Object.Instantiate(arg_599_1.paintGo_)

				var_602_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R1102")
				var_602_0.name = "R1102"
				var_602_0.transform.parent = arg_599_1.stage_.transform
				var_602_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_599_1.bgs_.R1102 = var_602_0
			end

			if 2 < arg_599_1.time_ and arg_599_1.time_ <= 2 + arg_602_0 then
				local var_602_1 = arg_599_1.bgs_.R1102

				arg_599_1.bgs_.R1102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_602_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_602_2 = var_602_1:GetComponent("SpriteRenderer")

				if var_602_2 and var_602_2.sprite then
					local var_602_3 = 2 * (var_602_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_602_1.transform.localScale = Vector3.New(var_602_3 / var_602_2.sprite.bounds.size.y < var_602_3 * manager.ui.mainCameraCom_.aspect / var_602_2.sprite.bounds.size.x and var_602_3 * manager.ui.mainCameraCom_.aspect / var_602_2.sprite.bounds.size.x or var_602_3 / var_602_2.sprite.bounds.size.y, var_602_3 / var_602_2.sprite.bounds.size.y < var_602_3 * manager.ui.mainCameraCom_.aspect / var_602_2.sprite.bounds.size.x and var_602_3 * manager.ui.mainCameraCom_.aspect / var_602_2.sprite.bounds.size.x or var_602_3 / var_602_2.sprite.bounds.size.y, 0)
				end

				for iter_602_0, iter_602_1 in pairs(arg_599_1.bgs_) do
					if iter_602_0 ~= "R1102" then
						iter_602_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_602_4 = 0

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_4 + arg_602_0 then
				arg_599_1.mask_.enabled = true
				arg_599_1.mask_.raycastTarget = true

				arg_599_1:SetGaussion(false)
			end

			local var_602_5 = 2

			if var_602_4 <= arg_599_1.time_ and arg_599_1.time_ < var_602_4 + var_602_5 then
				local var_602_6 = Color.New(1, 0.9764151, 0.9764151)

				var_602_6.a = Mathf.Lerp(0, 1, (arg_599_1.time_ - var_602_4) / var_602_5)
				arg_599_1.mask_.color = var_602_6
			end

			if arg_599_1.time_ >= var_602_4 + var_602_5 and arg_599_1.time_ < var_602_4 + var_602_5 + arg_602_0 then
				local var_602_7 = Color.New(1, 0.9764151, 0.9764151)

				var_602_7.a = 1
				arg_599_1.mask_.color = var_602_7
			end

			local var_602_8 = 2

			if 2 < arg_599_1.time_ and arg_599_1.time_ <= var_602_8 + arg_602_0 then
				arg_599_1.mask_.enabled = true
				arg_599_1.mask_.raycastTarget = true

				arg_599_1:SetGaussion(false)
			end

			local var_602_9 = 2

			if var_602_8 <= arg_599_1.time_ and arg_599_1.time_ < var_602_8 + var_602_9 then
				local var_602_10 = Color.New(1, 0.9764151, 0.9764151)

				var_602_10.a = Mathf.Lerp(1, 0, (arg_599_1.time_ - var_602_8) / var_602_9)
				arg_599_1.mask_.color = var_602_10
			end

			if arg_599_1.time_ >= var_602_8 + var_602_9 and arg_599_1.time_ < var_602_8 + var_602_9 + arg_602_0 then
				local var_602_11 = Color.New(1, 0.9764151, 0.9764151)

				arg_599_1.mask_.enabled = false
				var_602_11.a = 0
				arg_599_1.mask_.color = var_602_11
			end

			if arg_599_1.frameCnt_ <= 1 then
				arg_599_1.dialog_:SetActive(false)
			end

			local var_602_12 = 3.975
			local var_602_13 = 0.725

			if 3.975 < arg_599_1.time_ and arg_599_1.time_ <= var_602_12 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0

				arg_599_1.dialog_:SetActive(true)

				arg_599_1.dialogCg_.alpha = 0

				local var_602_14 = LeanTween.value(arg_599_1.dialog_, 0, 1, 0.3)

				var_602_14:setOnUpdate(LuaHelper.FloatAction(function(arg_603_0)
					arg_599_1.dialogCg_.alpha = arg_603_0
				end))
				var_602_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_599_1.dialog_)
					var_602_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_599_1.duration_ = arg_599_1.duration_ + 0.3

				SetActive(arg_599_1.leftNameGo_, false)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_15 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(910601156).content)

				arg_599_1.text_.text = var_602_15

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_17 = 29 <= 0 and var_602_13 or var_602_13 * (utf8.len(var_602_15) / 29)

				if (29 <= 0 and var_602_13 or var_602_13 * (utf8.len(var_602_15) / 29)) > 0 and var_602_13 < var_602_17 then
					arg_599_1.talkMaxDuration = var_602_17
					var_602_12 = var_602_12 + 0.3

					if var_602_17 + var_602_12 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_17 + var_602_12
					end
				end

				arg_599_1.text_.text = var_602_15
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_18 = var_602_12 + 0.3
			local var_602_19 = math.max(var_602_13, arg_599_1.talkMaxDuration)

			if var_602_12 + 0.3 <= arg_599_1.time_ and arg_599_1.time_ < var_602_18 + var_602_19 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_18) / var_602_19

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_18 + var_602_19 and arg_599_1.time_ < var_602_18 + var_602_19 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play910601157 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 910601157
		arg_605_1.duration_ = 9

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play910601158(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.mask_.enabled = true
				arg_605_1.mask_.raycastTarget = true

				arg_605_1:SetGaussion(false)
			end

			local var_608_0 = 2

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_0 then
				local var_608_1 = Color.New(1, 0.9764151, 0.9764151)

				var_608_1.a = Mathf.Lerp(0, 1, (arg_605_1.time_ - 0) / var_608_0)
				arg_605_1.mask_.color = var_608_1
			end

			if arg_605_1.time_ >= 0 + var_608_0 and arg_605_1.time_ < 0 + var_608_0 + arg_608_0 then
				local var_608_2 = Color.New(1, 0.9764151, 0.9764151)

				var_608_2.a = 1
				arg_605_1.mask_.color = var_608_2
			end

			local var_608_3 = 2

			if 2 < arg_605_1.time_ and arg_605_1.time_ <= var_608_3 + arg_608_0 then
				arg_605_1.mask_.enabled = true
				arg_605_1.mask_.raycastTarget = true

				arg_605_1:SetGaussion(false)
			end

			local var_608_4 = 2

			if var_608_3 <= arg_605_1.time_ and arg_605_1.time_ < var_608_3 + var_608_4 then
				local var_608_5 = Color.New(1, 0.9764151, 0.9764151)

				var_608_5.a = Mathf.Lerp(1, 0, (arg_605_1.time_ - var_608_3) / var_608_4)
				arg_605_1.mask_.color = var_608_5
			end

			if arg_605_1.time_ >= var_608_3 + var_608_4 and arg_605_1.time_ < var_608_3 + var_608_4 + arg_608_0 then
				local var_608_6 = Color.New(1, 0.9764151, 0.9764151)

				arg_605_1.mask_.enabled = false
				var_608_6.a = 0
				arg_605_1.mask_.color = var_608_6
			end

			local var_608_7 = "R2802"

			if arg_605_1.bgs_.R2802 == nil then
				local var_608_8 = Object.Instantiate(arg_605_1.paintGo_)

				var_608_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_608_7)
				var_608_8.name = var_608_7
				var_608_8.transform.parent = arg_605_1.stage_.transform
				var_608_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_605_1.bgs_[var_608_7] = var_608_8
			end

			if 2 < arg_605_1.time_ and arg_605_1.time_ <= 2 + arg_608_0 then
				local var_608_9 = arg_605_1.bgs_.R2802

				arg_605_1.bgs_.R2802.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_608_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_608_10 = var_608_9:GetComponent("SpriteRenderer")

				if var_608_10 and var_608_10.sprite then
					local var_608_11 = 2 * (var_608_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_608_9.transform.localScale = Vector3.New(var_608_11 / var_608_10.sprite.bounds.size.y < var_608_11 * manager.ui.mainCameraCom_.aspect / var_608_10.sprite.bounds.size.x and var_608_11 * manager.ui.mainCameraCom_.aspect / var_608_10.sprite.bounds.size.x or var_608_11 / var_608_10.sprite.bounds.size.y, var_608_11 / var_608_10.sprite.bounds.size.y < var_608_11 * manager.ui.mainCameraCom_.aspect / var_608_10.sprite.bounds.size.x and var_608_11 * manager.ui.mainCameraCom_.aspect / var_608_10.sprite.bounds.size.x or var_608_11 / var_608_10.sprite.bounds.size.y, 0)
				end

				for iter_608_0, iter_608_1 in pairs(arg_605_1.bgs_) do
					if iter_608_0 ~= "R2802" then
						iter_608_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_605_1.frameCnt_ <= 1 then
				arg_605_1.dialog_:SetActive(false)
			end

			local var_608_12 = 4
			local var_608_13 = 0.8

			if 4 < arg_605_1.time_ and arg_605_1.time_ <= var_608_12 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0

				arg_605_1.dialog_:SetActive(true)

				arg_605_1.dialogCg_.alpha = 0

				local var_608_14 = LeanTween.value(arg_605_1.dialog_, 0, 1, 0.3)

				var_608_14:setOnUpdate(LuaHelper.FloatAction(function(arg_609_0)
					arg_605_1.dialogCg_.alpha = arg_609_0
				end))
				var_608_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_605_1.dialog_)
					var_608_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_605_1.duration_ = arg_605_1.duration_ + 0.3

				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_15 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(910601157).content)

				arg_605_1.text_.text = var_608_15

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_17 = 32 <= 0 and var_608_13 or var_608_13 * (utf8.len(var_608_15) / 32)

				if (32 <= 0 and var_608_13 or var_608_13 * (utf8.len(var_608_15) / 32)) > 0 and var_608_13 < var_608_17 then
					arg_605_1.talkMaxDuration = var_608_17
					var_608_12 = var_608_12 + 0.3

					if var_608_17 + var_608_12 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_17 + var_608_12
					end
				end

				arg_605_1.text_.text = var_608_15
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_18 = var_608_12 + 0.3
			local var_608_19 = math.max(var_608_13, arg_605_1.talkMaxDuration)

			if var_608_12 + 0.3 <= arg_605_1.time_ and arg_605_1.time_ < var_608_18 + var_608_19 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_18) / var_608_19

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_18 + var_608_19 and arg_605_1.time_ < var_608_18 + var_608_19 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play910601158 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 910601158
		arg_611_1.duration_ = 8.98

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play910601159(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.mask_.enabled = true
				arg_611_1.mask_.raycastTarget = true

				arg_611_1:SetGaussion(false)
			end

			local var_614_0 = 2

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 then
				local var_614_1 = Color.New(1, 0.9764151, 0.9764151)

				var_614_1.a = Mathf.Lerp(0, 1, (arg_611_1.time_ - 0) / var_614_0)
				arg_611_1.mask_.color = var_614_1
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 then
				local var_614_2 = Color.New(1, 0.9764151, 0.9764151)

				var_614_2.a = 1
				arg_611_1.mask_.color = var_614_2
			end

			local var_614_3 = 2

			if 2 < arg_611_1.time_ and arg_611_1.time_ <= var_614_3 + arg_614_0 then
				arg_611_1.mask_.enabled = true
				arg_611_1.mask_.raycastTarget = true

				arg_611_1:SetGaussion(false)
			end

			local var_614_4 = 2

			if var_614_3 <= arg_611_1.time_ and arg_611_1.time_ < var_614_3 + var_614_4 then
				local var_614_5 = Color.New(1, 0.9764151, 0.9764151)

				var_614_5.a = Mathf.Lerp(1, 0, (arg_611_1.time_ - var_614_3) / var_614_4)
				arg_611_1.mask_.color = var_614_5
			end

			if arg_611_1.time_ >= var_614_3 + var_614_4 and arg_611_1.time_ < var_614_3 + var_614_4 + arg_614_0 then
				local var_614_6 = Color.New(1, 0.9764151, 0.9764151)

				arg_611_1.mask_.enabled = false
				var_614_6.a = 0
				arg_611_1.mask_.color = var_614_6
			end

			local var_614_7 = "R4802"

			if arg_611_1.bgs_.R4802 == nil then
				local var_614_8 = Object.Instantiate(arg_611_1.paintGo_)

				var_614_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_614_7)
				var_614_8.name = var_614_7
				var_614_8.transform.parent = arg_611_1.stage_.transform
				var_614_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_611_1.bgs_[var_614_7] = var_614_8
			end

			if 2 < arg_611_1.time_ and arg_611_1.time_ <= 2 + arg_614_0 then
				local var_614_9 = arg_611_1.bgs_.R4802

				arg_611_1.bgs_.R4802.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_614_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_614_10 = var_614_9:GetComponent("SpriteRenderer")

				if var_614_10 and var_614_10.sprite then
					local var_614_11 = 2 * (var_614_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_614_9.transform.localScale = Vector3.New(var_614_11 / var_614_10.sprite.bounds.size.y < var_614_11 * manager.ui.mainCameraCom_.aspect / var_614_10.sprite.bounds.size.x and var_614_11 * manager.ui.mainCameraCom_.aspect / var_614_10.sprite.bounds.size.x or var_614_11 / var_614_10.sprite.bounds.size.y, var_614_11 / var_614_10.sprite.bounds.size.y < var_614_11 * manager.ui.mainCameraCom_.aspect / var_614_10.sprite.bounds.size.x and var_614_11 * manager.ui.mainCameraCom_.aspect / var_614_10.sprite.bounds.size.x or var_614_11 / var_614_10.sprite.bounds.size.y, 0)
				end

				for iter_614_0, iter_614_1 in pairs(arg_611_1.bgs_) do
					if iter_614_0 ~= "R4802" then
						iter_614_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_611_1.frameCnt_ <= 1 then
				arg_611_1.dialog_:SetActive(false)
			end

			local var_614_12 = 3.975
			local var_614_13 = 0.35

			if 3.975 < arg_611_1.time_ and arg_611_1.time_ <= var_614_12 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0

				arg_611_1.dialog_:SetActive(true)

				arg_611_1.dialogCg_.alpha = 0

				local var_614_14 = LeanTween.value(arg_611_1.dialog_, 0, 1, 0.3)

				var_614_14:setOnUpdate(LuaHelper.FloatAction(function(arg_615_0)
					arg_611_1.dialogCg_.alpha = arg_615_0
				end))
				var_614_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_611_1.dialog_)
					var_614_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_611_1.duration_ = arg_611_1.duration_ + 0.3

				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_15 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(910601158).content)

				arg_611_1.text_.text = var_614_15

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_17 = 14 <= 0 and var_614_13 or var_614_13 * (utf8.len(var_614_15) / 14)

				if (14 <= 0 and var_614_13 or var_614_13 * (utf8.len(var_614_15) / 14)) > 0 and var_614_13 < var_614_17 then
					arg_611_1.talkMaxDuration = var_614_17
					var_614_12 = var_614_12 + 0.3

					if var_614_17 + var_614_12 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_17 + var_614_12
					end
				end

				arg_611_1.text_.text = var_614_15
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_18 = var_614_12 + 0.3
			local var_614_19 = math.max(var_614_13, arg_611_1.talkMaxDuration)

			if var_614_12 + 0.3 <= arg_611_1.time_ and arg_611_1.time_ < var_614_18 + var_614_19 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_18) / var_614_19

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_18 + var_614_19 and arg_611_1.time_ < var_614_18 + var_614_19 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play910601159 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 910601159
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play910601160(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0
			local var_620_1 = 0.75

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0

				arg_617_1.dialog_:SetActive(true)

				arg_617_1.dialogCg_.alpha = 0

				local var_620_2 = LeanTween.value(arg_617_1.dialog_, 0, 1, 0.3)

				var_620_2:setOnUpdate(LuaHelper.FloatAction(function(arg_621_0)
					arg_617_1.dialogCg_.alpha = arg_621_0
				end))
				var_620_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_617_1.dialog_)
					var_620_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_617_1.duration_ = arg_617_1.duration_ + 0.3

				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_3 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(910601159).content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 30 <= 0 and var_620_1 or var_620_1 * (utf8.len(var_620_3) / 30)

				if (30 <= 0 and var_620_1 or var_620_1 * (utf8.len(var_620_3) / 30)) > 0 and var_620_1 < var_620_5 then
					arg_617_1.talkMaxDuration = var_620_5
					var_620_0 = var_620_0 + 0.3

					if var_620_5 + var_620_0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + var_620_0
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_6 = var_620_0 + 0.3
			local var_620_7 = math.max(var_620_1, arg_617_1.talkMaxDuration)

			if var_620_0 + 0.3 <= arg_617_1.time_ and arg_617_1.time_ < var_620_6 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_6) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_6 + var_620_7 and arg_617_1.time_ < var_620_6 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play910601160 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 910601160
		arg_623_1.duration_ = 9

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play910601161(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.mask_.enabled = true
				arg_623_1.mask_.raycastTarget = true

				arg_623_1:SetGaussion(false)
			end

			local var_626_0 = 2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 then
				local var_626_1 = Color.New(0, 0, 0)

				var_626_1.a = Mathf.Lerp(0, 1, (arg_623_1.time_ - 0) / var_626_0)
				arg_623_1.mask_.color = var_626_1
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 then
				local var_626_2 = Color.New(0, 0, 0)

				var_626_2.a = 1
				arg_623_1.mask_.color = var_626_2
			end

			local var_626_3 = 2

			if 2 < arg_623_1.time_ and arg_623_1.time_ <= var_626_3 + arg_626_0 then
				arg_623_1.mask_.enabled = true
				arg_623_1.mask_.raycastTarget = true

				arg_623_1:SetGaussion(false)
			end

			local var_626_4 = 2

			if var_626_3 <= arg_623_1.time_ and arg_623_1.time_ < var_626_3 + var_626_4 then
				local var_626_5 = Color.New(0, 0, 0)

				var_626_5.a = Mathf.Lerp(1, 0, (arg_623_1.time_ - var_626_3) / var_626_4)
				arg_623_1.mask_.color = var_626_5
			end

			if arg_623_1.time_ >= var_626_3 + var_626_4 and arg_623_1.time_ < var_626_3 + var_626_4 + arg_626_0 then
				local var_626_6 = Color.New(0, 0, 0)

				arg_623_1.mask_.enabled = false
				var_626_6.a = 0
				arg_623_1.mask_.color = var_626_6
			end

			if 2 < arg_623_1.time_ and arg_623_1.time_ <= 2 + arg_626_0 then
				local var_626_7 = arg_623_1.bgs_.ST60

				arg_623_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_626_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_626_8 = var_626_7:GetComponent("SpriteRenderer")

				if var_626_8 and var_626_8.sprite then
					local var_626_9 = 2 * (var_626_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_626_7.transform.localScale = Vector3.New(var_626_9 / var_626_8.sprite.bounds.size.y < var_626_9 * manager.ui.mainCameraCom_.aspect / var_626_8.sprite.bounds.size.x and var_626_9 * manager.ui.mainCameraCom_.aspect / var_626_8.sprite.bounds.size.x or var_626_9 / var_626_8.sprite.bounds.size.y, var_626_9 / var_626_8.sprite.bounds.size.y < var_626_9 * manager.ui.mainCameraCom_.aspect / var_626_8.sprite.bounds.size.x and var_626_9 * manager.ui.mainCameraCom_.aspect / var_626_8.sprite.bounds.size.x or var_626_9 / var_626_8.sprite.bounds.size.y, 0)
				end

				for iter_626_0, iter_626_1 in pairs(arg_623_1.bgs_) do
					if iter_626_0 ~= "ST60" then
						iter_626_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_623_1.frameCnt_ <= 1 then
				arg_623_1.dialog_:SetActive(false)
			end

			local var_626_10 = 4
			local var_626_11 = 0.125

			if 4 < arg_623_1.time_ and arg_623_1.time_ <= var_626_10 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0

				arg_623_1.dialog_:SetActive(true)

				arg_623_1.dialogCg_.alpha = 0

				local var_626_12 = LeanTween.value(arg_623_1.dialog_, 0, 1, 0.3)

				var_626_12:setOnUpdate(LuaHelper.FloatAction(function(arg_627_0)
					arg_623_1.dialogCg_.alpha = arg_627_0
				end))
				var_626_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_623_1.dialog_)
					var_626_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_623_1.duration_ = arg_623_1.duration_ + 0.3

				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, true)
				arg_623_1.iconController_:SetSelectedState("hero")

				arg_623_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_623_1.callingController_:SetSelectedState("normal")

				arg_623_1.keyicon_.color = Color.New(1, 1, 1)
				arg_623_1.icon_.color = Color.New(1, 1, 1)

				local var_626_13 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(910601160).content)

				arg_623_1.text_.text = var_626_13

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_15 = 5 <= 0 and var_626_11 or var_626_11 * (utf8.len(var_626_13) / 5)

				if (5 <= 0 and var_626_11 or var_626_11 * (utf8.len(var_626_13) / 5)) > 0 and var_626_11 < var_626_15 then
					arg_623_1.talkMaxDuration = var_626_15
					var_626_10 = var_626_10 + 0.3

					if var_626_15 + var_626_10 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_15 + var_626_10
					end
				end

				arg_623_1.text_.text = var_626_13
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_16 = var_626_10 + 0.3
			local var_626_17 = math.max(var_626_11, arg_623_1.talkMaxDuration)

			if var_626_10 + 0.3 <= arg_623_1.time_ and arg_623_1.time_ < var_626_16 + var_626_17 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_16) / var_626_17

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_16 + var_626_17 and arg_623_1.time_ < var_626_16 + var_626_17 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play910601161 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 910601161
		arg_629_1.duration_ = 4

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
			arg_629_1.auto_ = false
		end

		function arg_629_1.playNext_(arg_631_0)
			arg_629_1.onStoryFinished_()
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1.var_.moveOldPos1011ui_story = arg_629_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_632_0 = 0.001

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_0 then
				arg_629_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_629_1.time_ - 2) / var_632_0)
				arg_629_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1011ui_story"].transform.position).z)
				arg_629_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1011ui_story"].transform.localEulerAngles = arg_629_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_629_1.time_ >= 2 + var_632_0 and arg_629_1.time_ < 2 + var_632_0 + arg_632_0 then
				arg_629_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_629_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1011ui_story"].transform.position).z)
				arg_629_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1011ui_story"].transform.localEulerAngles = arg_629_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_632_1 = arg_629_1.actors_["1011ui_story"]

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 and not isNil(var_632_1) and arg_629_1.var_.characterEffect1011ui_story == nil then
				arg_629_1.var_.characterEffect1011ui_story = var_632_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_2 = 0.200000002980232

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_2 and not isNil(var_632_1) then
				if arg_629_1.var_.characterEffect1011ui_story and not isNil(var_632_1) then
					arg_629_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= 2 + var_632_2 and arg_629_1.time_ < 2 + var_632_2 + arg_632_0 and not isNil(var_632_1) and arg_629_1.var_.characterEffect1011ui_story then
				arg_629_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_632_4 = arg_629_1.actors_["1084ui_story"].transform

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1.var_.moveOldPos1084ui_story = var_632_4.localPosition
			end

			local var_632_5 = 0.001

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_5 then
				var_632_4.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_629_1.time_ - 2) / var_632_5)
				var_632_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_4.position).x, (manager.ui.mainCamera.transform.position - var_632_4.position).y, (manager.ui.mainCamera.transform.position - var_632_4.position).z)
				var_632_4.localEulerAngles.z = 0
				var_632_4.localEulerAngles.x = 0
				var_632_4.localEulerAngles = var_632_4.localEulerAngles
			end

			if arg_629_1.time_ >= 2 + var_632_5 and arg_629_1.time_ < 2 + var_632_5 + arg_632_0 then
				var_632_4.localPosition = Vector3.New(0, -0.97, -6)
				var_632_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_4.position).x, (manager.ui.mainCamera.transform.position - var_632_4.position).y, (manager.ui.mainCamera.transform.position - var_632_4.position).z)
				var_632_4.localEulerAngles.z = 0
				var_632_4.localEulerAngles.x = 0
				var_632_4.localEulerAngles = var_632_4.localEulerAngles
			end

			local var_632_6 = arg_629_1.actors_["1084ui_story"].transform

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1.var_.moveOldPos1084ui_story = var_632_6.localPosition
			end

			local var_632_7 = 0.001

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_7 then
				var_632_6.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_629_1.time_ - 2) / var_632_7)
				var_632_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_6.position).x, (manager.ui.mainCamera.transform.position - var_632_6.position).y, (manager.ui.mainCamera.transform.position - var_632_6.position).z)
				var_632_6.localEulerAngles.z = 0
				var_632_6.localEulerAngles.x = 0
				var_632_6.localEulerAngles = var_632_6.localEulerAngles
			end

			if arg_629_1.time_ >= 2 + var_632_7 and arg_629_1.time_ < 2 + var_632_7 + arg_632_0 then
				var_632_6.localPosition = Vector3.New(0, -0.97, -6)
				var_632_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_6.position).x, (manager.ui.mainCamera.transform.position - var_632_6.position).y, (manager.ui.mainCamera.transform.position - var_632_6.position).z)
				var_632_6.localEulerAngles.z = 0
				var_632_6.localEulerAngles.x = 0
				var_632_6.localEulerAngles = var_632_6.localEulerAngles
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_632_8 = arg_629_1.actors_["1084ui_story"]

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 and not isNil(var_632_8) and arg_629_1.var_.characterEffect1084ui_story == nil then
				arg_629_1.var_.characterEffect1084ui_story = var_632_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_9 = 0.200000002980232

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_9 and not isNil(var_632_8) then
				if arg_629_1.var_.characterEffect1084ui_story and not isNil(var_632_8) then
					arg_629_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= 2 + var_632_9 and arg_629_1.time_ < 2 + var_632_9 + arg_632_0 and not isNil(var_632_8) and arg_629_1.var_.characterEffect1084ui_story then
				arg_629_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_632_11 = arg_629_1.actors_["1028ui_story"].transform

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1.var_.moveOldPos1028ui_story = var_632_11.localPosition
			end

			local var_632_12 = 0.001

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_12 then
				var_632_11.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1028ui_story, Vector3.New(-0.7, -0.9, -5.9), (arg_629_1.time_ - 2) / var_632_12)
				var_632_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_11.position).x, (manager.ui.mainCamera.transform.position - var_632_11.position).y, (manager.ui.mainCamera.transform.position - var_632_11.position).z)
				var_632_11.localEulerAngles.z = 0
				var_632_11.localEulerAngles.x = 0
				var_632_11.localEulerAngles = var_632_11.localEulerAngles
			end

			if arg_629_1.time_ >= 2 + var_632_12 and arg_629_1.time_ < 2 + var_632_12 + arg_632_0 then
				var_632_11.localPosition = Vector3.New(-0.7, -0.9, -5.9)
				var_632_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_11.position).x, (manager.ui.mainCamera.transform.position - var_632_11.position).y, (manager.ui.mainCamera.transform.position - var_632_11.position).z)
				var_632_11.localEulerAngles.z = 0
				var_632_11.localEulerAngles.x = 0
				var_632_11.localEulerAngles = var_632_11.localEulerAngles
			end

			local var_632_13 = arg_629_1.actors_["1028ui_story"]

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 and not isNil(var_632_13) and arg_629_1.var_.characterEffect1028ui_story == nil then
				arg_629_1.var_.characterEffect1028ui_story = var_632_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_14 = 0.200000002980232

			if 2 <= arg_629_1.time_ and arg_629_1.time_ < 2 + var_632_14 and not isNil(var_632_13) then
				if arg_629_1.var_.characterEffect1028ui_story and not isNil(var_632_13) then
					arg_629_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= 2 + var_632_14 and arg_629_1.time_ < 2 + var_632_14 + arg_632_0 and not isNil(var_632_13) and arg_629_1.var_.characterEffect1028ui_story then
				arg_629_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action6_1")
			end

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= 2 + arg_632_0 then
				arg_629_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_632_16 = 2

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= var_632_16 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_17 = 0.034000001847744

			if var_632_16 <= arg_629_1.time_ and arg_629_1.time_ < var_632_16 + var_632_17 then
				local var_632_18 = Color.New(1, 1, 1)

				var_632_18.a = Mathf.Lerp(1, 0, (arg_629_1.time_ - var_632_16) / var_632_17)
				arg_629_1.mask_.color = var_632_18
			end

			if arg_629_1.time_ >= var_632_16 + var_632_17 and arg_629_1.time_ < var_632_16 + var_632_17 + arg_632_0 then
				local var_632_19 = Color.New(1, 1, 1)

				arg_629_1.mask_.enabled = false
				var_632_19.a = 0
				arg_629_1.mask_.color = var_632_19
			end

			local var_632_20 = 0

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_20 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_21 = 1

			if var_632_20 <= arg_629_1.time_ and arg_629_1.time_ < var_632_20 + var_632_21 then
				local var_632_22 = Color.New(1, 1, 1)

				var_632_22.a = Mathf.Lerp(0, 1, (arg_629_1.time_ - var_632_20) / var_632_21)
				arg_629_1.mask_.color = var_632_22
			end

			if arg_629_1.time_ >= var_632_20 + var_632_21 and arg_629_1.time_ < var_632_20 + var_632_21 + arg_632_0 then
				local var_632_23 = Color.New(1, 1, 1)

				var_632_23.a = 1
				arg_629_1.mask_.color = var_632_23
			end

			local var_632_24 = 1

			if 1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_24 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_25 = 1.20000000298023

			if var_632_24 <= arg_629_1.time_ and arg_629_1.time_ < var_632_24 + var_632_25 then
				local var_632_26 = Color.New(1, 1, 1)

				var_632_26.a = Mathf.Lerp(1, 0, (arg_629_1.time_ - var_632_24) / var_632_25)
				arg_629_1.mask_.color = var_632_26
			end

			if arg_629_1.time_ >= var_632_24 + var_632_25 and arg_629_1.time_ < var_632_24 + var_632_25 + arg_632_0 then
				local var_632_27 = Color.New(1, 1, 1)

				arg_629_1.mask_.enabled = false
				var_632_27.a = 0
				arg_629_1.mask_.color = var_632_27
			end

			if 1 < arg_629_1.time_ and arg_629_1.time_ <= 1 + arg_632_0 then
				local var_632_28 = arg_629_1.bgs_.ST60

				arg_629_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_632_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_632_29 = var_632_28:GetComponent("SpriteRenderer")

				if var_632_29 and var_632_29.sprite then
					local var_632_30 = 2 * (var_632_28.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_632_28.transform.localScale = Vector3.New(var_632_30 / var_632_29.sprite.bounds.size.y < var_632_30 * manager.ui.mainCameraCom_.aspect / var_632_29.sprite.bounds.size.x and var_632_30 * manager.ui.mainCameraCom_.aspect / var_632_29.sprite.bounds.size.x or var_632_30 / var_632_29.sprite.bounds.size.y, var_632_30 / var_632_29.sprite.bounds.size.y < var_632_30 * manager.ui.mainCameraCom_.aspect / var_632_29.sprite.bounds.size.x and var_632_30 * manager.ui.mainCameraCom_.aspect / var_632_29.sprite.bounds.size.x or var_632_30 / var_632_29.sprite.bounds.size.y, 0)
				end

				for iter_632_0, iter_632_1 in pairs(arg_629_1.bgs_) do
					if iter_632_0 ~= "ST60" then
						iter_632_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_629_1.frameCnt_ <= 1 then
				arg_629_1.dialog_:SetActive(false)
			end

			local var_632_31 = 2
			local var_632_32 = 0.6

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= var_632_31 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				arg_629_1.dialog_:SetActive(true)

				arg_629_1.dialogCg_.alpha = 0

				local var_632_33 = LeanTween.value(arg_629_1.dialog_, 0, 1, 0.3)

				var_632_33:setOnUpdate(LuaHelper.FloatAction(function(arg_633_0)
					arg_629_1.dialogCg_.alpha = arg_633_0
				end))
				var_632_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_629_1.dialog_)
					var_632_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_629_1.duration_ = arg_629_1.duration_ + 0.3

				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_34 = arg_629_1:GetWordFromCfg(910601161)
				local var_632_35 = arg_629_1:FormatText(var_632_34.content)

				arg_629_1.text_.text = var_632_35

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_37 = 5 <= 0 and var_632_32 or var_632_32 * (utf8.len(var_632_35) / 5)

				if (5 <= 0 and var_632_32 or var_632_32 * (utf8.len(var_632_35) / 5)) > 0 and var_632_32 < var_632_37 then
					arg_629_1.talkMaxDuration = var_632_37
					var_632_31 = var_632_31 + 0.3

					if var_632_37 + var_632_31 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_37 + var_632_31
					end
				end

				arg_629_1.text_.text = var_632_35
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601161", "story_v_out_910601.awb") ~= 0 then
					local var_632_38 = manager.audio:GetVoiceLength("story_v_out_910601", "910601161", "story_v_out_910601.awb") / 1000

					if var_632_38 + var_632_31 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_38 + var_632_31
					end

					if var_632_34.prefab_name ~= "" and arg_629_1.actors_[var_632_34.prefab_name] ~= nil then
						local var_632_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_34.prefab_name].transform, "story_v_out_910601", "910601161", "story_v_out_910601.awb")

						arg_629_1:RecordAudio("910601161", var_632_39)
						arg_629_1:RecordAudio("910601161", var_632_39)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_910601", "910601161", "story_v_out_910601.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_910601", "910601161", "story_v_out_910601.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_40 = var_632_31 + 0.3
			local var_632_41 = math.max(var_632_32, arg_629_1.talkMaxDuration)

			if var_632_31 + 0.3 <= arg_629_1.time_ and arg_629_1.time_ < var_632_40 + var_632_41 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_40) / var_632_41

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_40 + var_632_41 and arg_629_1.time_ < var_632_40 + var_632_41 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_629_1:InitPlayNodeList()
	end,
	Play910601072 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 910601072
		arg_635_1.duration_ = 2

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play910601073(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.var_.moveOldPos1028ui_story = arg_635_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_638_0 = 0.001

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_0 then
				arg_635_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_635_1.time_ - 0) / var_638_0)
				arg_635_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1028ui_story"].transform.position).z)
				arg_635_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1028ui_story"].transform.localEulerAngles = arg_635_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_635_1.time_ >= 0 + var_638_0 and arg_635_1.time_ < 0 + var_638_0 + arg_638_0 then
				arg_635_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0.7, -0.9, -5.9)
				arg_635_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_635_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_635_1.actors_["1028ui_story"].transform.position).z)
				arg_635_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_635_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_635_1.actors_["1028ui_story"].transform.localEulerAngles = arg_635_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			local var_638_1 = arg_635_1.actors_["1028ui_story"]

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1028ui_story == nil then
				arg_635_1.var_.characterEffect1028ui_story = var_638_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_2 = 0.200000002980232

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_2 and not isNil(var_638_1) then
				if arg_635_1.var_.characterEffect1028ui_story and not isNil(var_638_1) then
					arg_635_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_635_1.time_ >= 0 + var_638_2 and arg_635_1.time_ < 0 + var_638_2 + arg_638_0 and not isNil(var_638_1) and arg_635_1.var_.characterEffect1028ui_story then
				arg_635_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_638_4 = "1028ui_story"

			if arg_635_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_638_5 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_635_1.stage_.transform)

				var_638_5.name = var_638_4
				var_638_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_635_1.actors_[var_638_4] = var_638_5

				local var_638_6 = var_638_5:GetComponentInChildren(typeof(CharacterEffect))

				var_638_6.enabled = true

				local var_638_7 = GameObjectTools.GetOrAddComponent(var_638_5, typeof(DynamicBoneHelper))

				if var_638_7 then
					var_638_7:EnableDynamicBone(false)
				end

				arg_635_1:ShowWeapon(var_638_6.transform, false)

				arg_635_1.var_[var_638_4 .. "Animator"] = var_638_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_635_1.var_[var_638_4 .. "Animator"].applyRootMotion = true
				arg_635_1.var_[var_638_4 .. "LipSync"] = var_638_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			local var_638_8 = "1028ui_story"

			if arg_635_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_638_9 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_635_1.stage_.transform)

				var_638_9.name = var_638_8
				var_638_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_635_1.actors_[var_638_8] = var_638_9

				local var_638_10 = var_638_9:GetComponentInChildren(typeof(CharacterEffect))

				var_638_10.enabled = true

				local var_638_11 = GameObjectTools.GetOrAddComponent(var_638_9, typeof(DynamicBoneHelper))

				if var_638_11 then
					var_638_11:EnableDynamicBone(false)
				end

				arg_635_1:ShowWeapon(var_638_10.transform, false)

				arg_635_1.var_[var_638_8 .. "Animator"] = var_638_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_635_1.var_[var_638_8 .. "Animator"].applyRootMotion = true
				arg_635_1.var_[var_638_8 .. "LipSync"] = var_638_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_638_12 = 0
			local var_638_13 = 0.125

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= var_638_12 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_14 = arg_635_1:GetWordFromCfg(910601072)
				local var_638_15 = arg_635_1:FormatText(var_638_14.content)

				arg_635_1.text_.text = var_638_15

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_17 = 5 <= 0 and var_638_13 or var_638_13 * (utf8.len(var_638_15) / 5)

				if (5 <= 0 and var_638_13 or var_638_13 * (utf8.len(var_638_15) / 5)) > 0 and var_638_13 < var_638_17 then
					arg_635_1.talkMaxDuration = var_638_17

					if var_638_17 + var_638_12 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_17 + var_638_12
					end
				end

				arg_635_1.text_.text = var_638_15
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_910601", "910601072", "story_v_out_910601.awb") ~= 0 then
					local var_638_18 = manager.audio:GetVoiceLength("story_v_out_910601", "910601072", "story_v_out_910601.awb") / 1000

					if var_638_18 + var_638_12 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_18 + var_638_12
					end

					if var_638_14.prefab_name ~= "" and arg_635_1.actors_[var_638_14.prefab_name] ~= nil then
						local var_638_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_14.prefab_name].transform, "story_v_out_910601", "910601072", "story_v_out_910601.awb")

						arg_635_1:RecordAudio("910601072", var_638_19)
						arg_635_1:RecordAudio("910601072", var_638_19)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_910601", "910601072", "story_v_out_910601.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_910601", "910601072", "story_v_out_910601.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_20 = math.max(var_638_13, arg_635_1.talkMaxDuration)

			if var_638_12 <= arg_635_1.time_ and arg_635_1.time_ < var_638_12 + var_638_20 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_12) / var_638_20

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_12 + var_638_20 and arg_635_1.time_ < var_638_12 + var_638_20 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_635_1:InitPlayNodeList()
	end,
	Play910601073 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 910601073
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play910601074(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["1028ui_story"]) and arg_639_1.var_.characterEffect1028ui_story == nil then
				arg_639_1.var_.characterEffect1028ui_story = arg_639_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["1028ui_story"]) then
				if arg_639_1.var_.characterEffect1028ui_story and not isNil(arg_639_1.actors_["1028ui_story"]) then
					arg_639_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_0)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["1028ui_story"]) and arg_639_1.var_.characterEffect1028ui_story then
				arg_639_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_642_1 = 0
			local var_642_2 = 1.125

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_3 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(910601073).content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_5 = 45 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_3) / 45)

				if (45 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_3) / 45)) > 0 and var_642_2 < var_642_5 then
					arg_639_1.talkMaxDuration = var_642_5

					if var_642_5 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_5 + var_642_1
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_6 = math.max(var_642_2, arg_639_1.talkMaxDuration)

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_6 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_1) / var_642_6

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_1 + var_642_6 and arg_639_1.time_ < var_642_1 + var_642_6 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play910601074 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 910601074
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play910601075(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = 0.575

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_1 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(910601074).content)

				arg_643_1.text_.text = var_646_1

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_3 = 23 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 23)

				if (23 <= 0 and var_646_0 or var_646_0 * (utf8.len(var_646_1) / 23)) > 0 and var_646_0 < var_646_3 then
					arg_643_1.talkMaxDuration = var_646_3

					if var_646_3 + 0 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_3 + 0
					end
				end

				arg_643_1.text_.text = var_646_1
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_4 = math.max(var_646_0, arg_643_1.talkMaxDuration)

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_4 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - 0) / var_646_4

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= 0 + var_646_4 and arg_643_1.time_ < 0 + var_646_4 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST60",
		"SofdecAsset/story/story_9106010.usm",
		"TextureConfig/Background/XH0201",
		"TextureConfig/Background/R1102",
		"TextureConfig/Background/R2802",
		"TextureConfig/Background/R4802"
	},
	voices = {
		"story_v_out_910601.awb"
	},
	skipMarkers = {
		910601112
	}
}
